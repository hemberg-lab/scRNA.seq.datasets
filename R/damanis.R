# GSE67835 - PMID:26060301
# Darmanis et al. (2015). A survey of human brain transcriptome diversity at the single cell level. 
# Human Neurons
# PNAS. 9;112(23):7285-90

library(scater)

# load data
data1 <- read.table("ExprMat1.txt", header=T)
ann1 <- read.table("Ann_part1.txt", header=T)
data2 <- read.table("ExprMat2.txt", header=T)
ann2 <- read.table("Ann_part2.txt", header=T)

DATA <- cbind(data1, data2)
ANN <- rbind(t(ann1), t(ann2))
rownames(ANN) = ANN[,8]

colnames(ANN) <- c("Source", "Species", "Tissue", "cell_type1", "age", "plate", "individual", "File")


# create scater object
pd <- new("AnnotatedDataFrame", data = as.data.frame(ANN))
sceset <- newSCESet(countData = DATA, phenoData = pd)

# use gene names as feature symbols
sceset@featureData@data$feature_symbol <- featureNames(sceset)

# save data
saveRDS(sceset, file = "darmanis.rds")
