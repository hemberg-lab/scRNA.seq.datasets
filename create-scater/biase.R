library(scater)

# load data
d <- read.table("data.txt", header = T)
d <- d[!duplicated(d$ID),]
rownames(d) <- d$ID
d <- d[,2:ncol(d)]

# cell annotations
ann <- read.table("biase_cell_types.txt", stringsAsFactors = F)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
biase <- newSCESet(fpkmData = as.matrix(d), phenoData = pd)
is_exprs(biase) <- exprs(biase) > 0
biase <- calculateQCMetrics(biase)

# use gene names as feature symbols
biase@featureData@data$feature_symbol <- featureNames(biase)
saveRDS(biase, "biase.rds")
