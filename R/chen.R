### DATA
d <- read.table("GSE87544_Merged_17samples_14437cells_count.txt")
rownames(d) <- d[,1]
d <- d[,2:ncol(d)]
d <- d[,order(colnames(d))]

### ANNOTATIONS
ann <- read.csv("GSE87544_1443737Cells.SVM.cluster.identity.renamed.csv")
rownames(ann) <- ann[,2]
colnames(ann)[3] <- "cell_type1"
ann <- ann[,3,drop = FALSE]
ann <- ann[order(rownames(ann)), , drop = FALSE]

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
sceset <- create_sce_from_counts(d, ann)
saveRDS(sceset, "chen.rds")
