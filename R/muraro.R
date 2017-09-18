### DATA
d <- read.table("data.csv", header = T, stringsAsFactors = F)
ann <- read.table("cell_type_annotation_Cels2016.csv", stringsAsFactors = F)

### ANNOTATIONS
d <- d[,colnames(d) %in% rownames(ann)]
ann <- ann[rownames(ann) %in% colnames(d),,drop = FALSE]
d <- d[,order(colnames(d))]
ann <- ann[order(rownames(ann)),,drop = FALSE]
colnames(ann) <- "cell_type1"
# format cell type names
ann$cell_type1[ann$cell_type1 == "duct"] <- "ductal"
ann$cell_type1[ann$cell_type1 == "pp"] <- "gamma"
tmp <- matrix(unlist(strsplit(rownames(ann),"[._]")), ncol=3, byrow=T)
ann$donor <- tmp[,1]
ann$batch <- tmp[,2]

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_normcounts(d, ann)
# use gene names as feature symbols
gene_names <- unlist(lapply(strsplit(rownames(sceset), "__"), "[[", 1))
rowData(sceset)$feature_symbol <- gene_names
# remove features with duplicated names
sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
saveRDS(sceset, "muraro.rds")
