library(scater)

# load data
zeisel <- read.table("zeisel.txt", sep = "\t", header = T)
rownames(zeisel) <- zeisel[ , 1]
zeisel <- zeisel[ , 3:dim(zeisel)[2]]
zeisel <- as.matrix(zeisel)

labs <- read.table("zeisel.txt", nrows = 1, stringsAsFactors = F)
labs <- as.character(labs[2:length(labs)])

# create cell annotations
ann <- data.frame(clust_id = labs)
labs[labs == "1"] = "interneurons"
labs[labs == "2"] = "s1pyramidal"
labs[labs == "3"] = "ca1pyramidal"
labs[labs == "4"] = "oligodendrocytes"
labs[labs == "5"] = "microglia"
labs[labs == "6"] = "endothelial"
labs[labs == "7"] = "astrocytes"
labs[labs == "8"] = "ependymal"
labs[labs == "9"] = "mural"
ann$cell_type1 <- labs
rownames(ann) <- colnames(zeisel)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
sceset <- newSCESet(countData = zeisel, phenoData = pd)
sceset <- calculateQCMetrics(sceset)

# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

# save data
saveRDS(sceset, file = "zeisel.rds")
