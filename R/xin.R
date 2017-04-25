library(scater)

# load the data
d <- read.table("data.txt", header = T)
genes <- read.csv("human_gene_annotation.csv", header = T)
rownames(d) <- genes[,2]
d <- d[,2:ncol(d)]

# load metadata
ann <- read.table("human_islet_cell_identity.txt", header = T, sep = "\t", stringsAsFactors = F)
rownames(ann) <- ann[,1]
rownames(ann) <- gsub(" ", "_", rownames(ann))
ann <- ann[,9:ncol(ann)]
colnames(ann)[length(colnames(ann))] <- "cell_type1"
pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(fpkmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
# run quality controls
sceset <- calculateQCMetrics(sceset)

# use gene names as feature symbols
sceset@featureData@data$feature_symbol <- featureNames(sceset)

# format cell type names
sceset@phenoData@data$cell_type1[sceset@phenoData@data$cell_type1 == "PP"] <- "gamma"
sceset@phenoData@data$cell_type1[sceset@phenoData@data$cell_type1 == "PP.contaminated"] <- "gamma.contaminated"

# save files
saveRDS(sceset, "xin.rds")
