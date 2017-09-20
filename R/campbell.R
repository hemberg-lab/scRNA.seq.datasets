### DATA
d <- read.table("GSE93374_Merged_all_020816_DGE.txt")
d <- d[,order(colnames(d))]

### ANNOTATIONS
ann <- read.table("GSE93374_cell_metadata.txt", sep = "\t", header = T)
ann <- ann[order(ann[,1]), ]
rownames(ann) <- ann[,1]
ann <- ann[,2:ncol(ann)]
colnames(ann)[9] <- "cell_type1"

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
sceset <- create_sce_from_counts(d, ann)
saveRDS(sceset, file = "campbell.rds")
