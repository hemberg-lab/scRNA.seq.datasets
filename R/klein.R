library(scater)

# load data
d0 <- read.csv("klein/GSM1599494_ES_d0_main.csv", header = FALSE)
d2 <- read.csv("klein/GSM1599497_ES_d2_LIFminus.csv", header = FALSE)
d4 <- read.csv("klein/GSM1599498_ES_d4_LIFminus.csv", header = FALSE)
d7 <- read.csv("klein/GSM1599499_ES_d7_LIFminus.csv", header = FALSE)

d <- cbind(d0, d2[,2:ncol(d2)], d4[,2:ncol(d4)], d7[,2:ncol(d7)])
rownames(d) <- d[,1]
d <- d[,2:ncol(d)]
colnames(d) <- paste0("cell", 1:ncol(d))

# cell annotations
ann <- data.frame(
    cell_type1 = c(rep("d0", ncol(d0) - 1), 
                   rep("d2", ncol(d2) - 1),
                   rep("d4", ncol(d4) - 1),
                   rep("d7", ncol(d7) - 1)))
rownames(ann) <- colnames(d)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
sceset <- newSCESet(countData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
sceset <- calculateQCMetrics(sceset)

# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# save data
saveRDS(sceset, "klein.rds")







