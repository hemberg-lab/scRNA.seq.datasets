### DATA
Nestorowa = read.table("coordinates_gene_counts_flow_cytometry.txt", header=T)
Anno = read.table("all_cell_types.txt", header=T)
Anno <- Anno[order(rownames(Anno)),]
rownames(Anno) <- gsub("-",".",rownames(Anno))

### ANNOTATIONS
expr_mat = t(Nestorowa[,28:length(Nestorowa[1,])])
#rownames(expr_mat) <- ensg2symbol(rownames(expr_mat));
colnames(expr_mat) <- Nestorowa[,1];
expr_order = order(colnames(expr_mat))
type <- Nestorowa[,26];
batch <- Nestorowa[,25];
batch = as.character(batch);
batch[batch == "batch_1"] <- "1"
batch[batch == "batch_2"] <- "2"
plate <- Nestorowa$plate.id
well <- Nestorowa$Well
Type_vec = c("LTHSC","LMPP","MPP","CMP","MEP","GMP","MPP","MPP","MPP","STHSC","ESLAM","Unknown","LTHSC","LMPP","MPP","CMP","MEP","GMP","MPP","MPP","MPP","MPP")
Sorting_vec = c("Lin-Kit+Sca1+Flk2-CD34-","Lin-Kit+Sca1+Flk2+CD34+","Lin-Kit+Sca1+Flk2-CD34+","Lin-Kit+Sca1-CD16/32-CD34+","Lin-Kit+Sca1-CD16/32-CD34-","Lin-Kit+Sca1-CD16/32+CD34+","Lin-Kit+Sca1+Flk2-CD34+CD150+CD48-","Lin-Kit+Sca1+Flk2-CD34+CD150+CD48+","Lin-Kit+Sca1+Flk2-CD34+CD150-CD48+","Lin-Kit+Sca1+Flk2-CD34+CD150-CD48-","EPCR+CD48–CD150+","Lin-Kit+Sca1+D34-Flk2-CD48-CD150+","Lin-Kit+Sca1+Flk2-CD34-","Lin-Kit+Sca1+Flk2+CD34+","Lin-Kit+Sca1+Flk2-CD34+","Lin-Kit+Sca1-CD16/32-CD34+","Lin-Kit+Sca1-CD16/32-CD34-","Lin-Kit+Sca1-CD16/32+CD34+","Lin-Kit+Sca1+Flk2-CD34+CD150+CD48-","Lin-Kit+Sca1+Flk2-CD34+CD150+CD48+","Lin-Kit+Sca1+Flk2-CD34+CD150-CD48+","Lin-Kit+Sca1+Flk2-CD34+CD150-CD48-")
Confidence_vec = c(rep("High", times=12), rep("Low",times=10))
assign_celltype <- function(x) {
    if(sum(x) == 1) {
        id <- which(x==1)+1
    } else if (sum(x[Confidence_vec=="High"]) >= 1) {
        id <- max(which(x[Confidence_vec=="High"] == 1))+1
    } else if (sum(x[Confidence_vec=="Low"]) >= 1) {
        id <- max(which(x[Confidence_vec=="Low"] == 1))+12+1
    } else {
        id <- 1;
    }
}
ids <- apply(Anno, 1, assign_celltype)
Types<- c("Unknown",Type_vec)[ids]
Sortings <- c("NA",Sorting_vec)[ids]
Confidences <- c("NA",Confidence_vec)[ids]
# To understand mapping
# cbind(Type_vec, Sotring_vec, Confidence_vec, colnames(Anno))
ncells <- length(Types)
Annotation = data.frame(batch=batch[expr_order],plate=plate[expr_order], WellID=well[expr_order], Source = rep("MmusBoneMarrow", times=ncells), cell_type1 = Types, type_confidence=Confidences, sorting=Sortings, genotype=rep("WildType", times=ncells));
rownames(Annotation) = rownames(Anno)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_logcounts(expr_mat[,expr_order], Annotation)
# convert ensembl ids into gene names
# gene symbols will be stored in the feature_symbol column of fData
sceset <- getBMFeatureAnnos(
    sceset, filters="ensembl_gene_id",
    biomart="ensembl", dataset="mmusculus_gene_ensembl")
# remove features with duplicated names
sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
saveRDS(sceset, file="nestorowa.rds")
