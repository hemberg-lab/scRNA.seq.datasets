library(scater)

# load the data
d <- read.table("data.csv", header = T, stringsAsFactors = F)
ann <- read.table("cell_type_annotation_Cels2016.csv", stringsAsFactors = F)

# fit data with annotations
d <- d[,colnames(d) %in% rownames(ann)]
ann <- ann[rownames(ann) %in% colnames(d),,drop = FALSE]
d <- d[,order(colnames(d))]
ann <- ann[order(rownames(ann)),,drop = FALSE]
colnames(ann) <- "cell_type1"
tmp <- matrix(unlist(strsplit(rownames(ann),"[._]")), ncol=3, byrow=T)
ann$donor <- tmp[,1]
ann$batch <- tmp[,2]

# create a scater object
pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(fpkmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
sceset <- calculateQCMetrics(sceset)
# use gene names as feature symbols
gene_names <- unlist(lapply(strsplit(featureNames(sceset), "__"), "[[", 1))
fData(sceset)$feature_symbol <- gene_names
# format cell type names
sceset@phenoData@data$cell_type1[sceset@phenoData@data$cell_type1 == "duct"] <- "ductal"
sceset@phenoData@data$cell_type1[sceset@phenoData@data$cell_type1 == "pp"] <- "gamma"

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, "muraro.rds")
