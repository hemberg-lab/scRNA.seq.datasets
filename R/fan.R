library(scater)

# load large and small files
d1 <- read.table("small_final.txt", header = T)
rownames(d1) <- d1[,1]
d1 <- d1[,2:ncol(d1)]
# colnames(d1) <- unlist(lapply(strsplit(colnames(d1), "_"), "[[", 3))

d2 <- read.table("large_final.txt", header = T)
d2 <- d2[!duplicated(d2[,1]), ]
rownames(d2) <- d2[,1]
d2 <- d2[,2:ncol(d2)]
# colnames(d2) <- unlist(lapply(strsplit(colnames(d2), "_"), "[[", 3))

# merge two tables
d1 <- d1[rownames(d1) %in% rownames(d2), ]
d2 <- d2[rownames(d2) %in% rownames(d1), ]
d1 <- d1[order(rownames(d1)), ]
d2 <- d2[order(rownames(d2)), ]
d <- cbind(d1, d2)

labs <- colnames(d)
labs[grep("ocyte",labs)] = "zygote"
labs[grep("zygote",labs)] = "zygote"
labs[grep("a.AM",labs)] = "zygote"
labs[grep("2.cell",labs)] = "2cell"
labs[grep("4.cell",labs)] = "4cell"
labs[grep("8.cell",labs)] = "8cell"
labs[grep("morula",labs)] = "16cell"
labs[grep("ICM",labs)] = "blast"
labs[grep("TE",labs)] = "blast"
labs[grep("blast",labs)] = "blast"

ann <- data.frame(cell_type1 = labs)
rownames(ann) <- colnames(d)

pd <- new("AnnotatedDataFrame", data = ann)
fan <- newSCESet(fpkmData = as.matrix(d), phenoData = pd)
is_exprs(fan) <- exprs(fan) > 0
fan <- calculateQCMetrics(fan)
# use gene names as feature symbols
fan@featureData@data$feature_symbol <- featureNames(fan)
saveRDS(fan, "fan.rds")
