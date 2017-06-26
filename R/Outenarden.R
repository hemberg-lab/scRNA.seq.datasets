#E-GEOD-76983
#Publication: Grun et atl. (2016) De novo prediction of stem cell identity using single-cell transcriptome data. Cell Stem Cell. 19 (2) 266-277. http://dx.doi.org/10.1016/j.stem.2016.05.010
#http://www.sciencedirect.com/science/article/pii/S1934590916300947
#Download Link: https://www.ebi.ac.uk/arrayexpress/experiments/E-GEOD-76983/
#Other: Mouse, bone marrow, transcript counts, CEL-Seq, bwa (align to transcriptome), short reads, 4bp UMIs (no error correction).

DATA = read.table("GSE76983_expdata_BMJhscC.csv", header=T)

expr_mat = as.matrix(DATA[,2:length(DATA[1,])]);
keep = colSums(expr_mat> 0) > 100; # Some cell QC (avoid all zero cells)
expr_mat = expr_mat[,keep];

gene_names = DATA[,1];
gene_names = matrix(unlist(strsplit(as.character(gene_names),"__")),ncol=2, byrow=T )
dups = duplicated(gene_names[,1])
gene_names[dups,1] = DATA[dups,1]
rownames(expr_mat) <- gene_names[,1];

labels = colnames(expr_mat);
ncells = length(labels)
sorting = rep("NA", times=ncells); type[grepl("HSC",labels)] <- "Lin-Kit+Sca1+CD48-CD150+"; #HSC
type = rep("Unknown", times=ncells); type[grepl("HSC",labels)] <- "HSC"; #HSC
thing = strsplit(labels,"_")
plate = unlist(lapply(thing, function(x){x[1]}));

Annotation = data.frame(batch=plate, plate=plate, Source = rep("MmusBoneMarrow", times=ncells), cell_type1 = type, sorting=sorting, genotype=rep("WildType", times=ncells));
rownames(Annotation) <- colnames(expr_mat)

require("scater")
pd <- new("AnnotatedDataFrame", data=Annotation)
sceset <- newSCESet(countData=expr_mat, phenoData=pd, logExprsOffset=1, lowerDetectionLimit=0)

saveRDS(sceset, file="Outenarden.rds")
