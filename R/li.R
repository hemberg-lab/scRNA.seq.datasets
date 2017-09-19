### DATA
d <- read.csv("data.csv")

### ANNOTATIONS
genes <- unlist(lapply(strsplit(as.character(d[,1]), "_"), "[[", 2))
d <- d[!duplicated(genes), ]
rownames(d) <- genes[!duplicated(genes)]
d <- d[,2:ncol(d)]
# metadata
ann <- data.frame(cell_type1 = unlist(lapply(strsplit(colnames(d), "__"), "[[", 2)))
rownames(ann) <- colnames(d)

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
sceset <- create_sce_from_counts(d, ann)
saveRDS(sceset, "li.rds")
