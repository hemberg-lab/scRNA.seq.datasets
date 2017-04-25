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

# create a scater object
pd <- new("AnnotatedDataFrame", data = ann)
muraro <- newSCESet(fpkmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
muraro <- calculateQCMetrics(muraro)
# use gene names as feature symbols
gene_names <- unlist(lapply(strsplit(featureNames(muraro), "__"), "[[", 1))
muraro@featureData@data$feature_symbol <- gene_names
# format cell type names
muraro@phenoData@data$cell_type1[muraro@phenoData@data$cell_type1 == "duct"] <- "ductal"
muraro@phenoData@data$cell_type1[muraro@phenoData@data$cell_type1 == "pp"] <- "gamma"
saveRDS(muraro, "muraro.rds")
