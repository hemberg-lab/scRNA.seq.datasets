### DATA
zeisel <- read.table("zeisel.txt", sep = "\t", header = T)
rownames(zeisel) <- zeisel[ , 1]
zeisel <- zeisel[ , 3:dim(zeisel)[2]]
zeisel <- as.matrix(zeisel)

### ANNOTATIONS
labs <- read.table("zeisel.txt", nrows = 1, stringsAsFactors = F)
labs <- as.character(labs[2:length(labs)])
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

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_counts(zeisel, ann)
saveRDS(sceset, file = "zeisel.rds")
