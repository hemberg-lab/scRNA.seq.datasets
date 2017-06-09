library(scater)

# load data
d <- read.csv("data.csv")

# gene names
genes <- unlist(lapply(strsplit(as.character(d[,1]), "_"), "[[", 2))
d <- d[!duplicated(genes), ]
rownames(d) <- genes[!duplicated(genes)]
d <- d[,2:ncol(d)]

# metadata
ann <- data.frame(cell_type1 = unlist(lapply(strsplit(colnames(d), "__"), "[[", 2)))
rownames(ann) <- colnames(d)

# create scater object
pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(countData = d, phenoData = pd)
sceset <- calculateQCMetrics(sceset)

# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

saveRDS(sceset, "li.rds")
