### DATA
data1 <- read.table("ExprMat1.txt", header=T)
ann1 <- read.table("Ann_part1.txt", header=T)
data2 <- read.table("ExprMat2.txt", header=T)
ann2 <- read.table("Ann_part2.txt", header=T)
DATA <- cbind(data1, data2)
ANN <- rbind(t(ann1), t(ann2))

### ANNOTATIONS
rownames(ANN) <- NULL
colnames(ANN) <- c("Source", "Species", "Tissue", "cell_type1", "age", "plate", "individual", "File")

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
sceset <- create_sce_from_counts(DATA, ANN)
saveRDS(sceset, file = "darmanis.rds")
