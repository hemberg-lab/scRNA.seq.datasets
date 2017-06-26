library(scater)

d <- read.csv("nsmb.2660-S2.csv")
rownames(d) <- d[,1]
d <- d[,3:92]

ct2 <- colnames(d)
ct2[grepl("Oocyte", ct2)] <- "oocyte"
ct2[grepl("Zygote", ct2)] <- "zygote"
ct2[grepl("X2.cell", ct2)] <- "2cell"
ct2[grepl("X4.cell", ct2)] <- "4cell"
ct2[grepl("X8.cell", ct2)] <- "8cell"
ct2[grepl("Morulae", ct2)] <- "morula"
ct2[grepl("Late.blastocyst", ct2)] <- "lateblast"

ct1 <- colnames(d)
ct1[grepl("Oocyte", ct1)] <- "zygote"
ct1[grepl("Zygote", ct1)] <- "zygote"
ct1[grepl("X2.cell", ct1)] <- "2cell"
ct1[grepl("X4.cell", ct1)] <- "4cell"
ct1[grepl("X8.cell", ct1)] <- "8cell"
ct1[grepl("Morulae", ct1)] <- "16cell"
ct1[grepl("Late.blastocyst", ct1)] <- "blast"

ann <- data.frame(cell_type1 = ct1, cell_type2 = ct2)
rownames(ann) <- colnames(d)

pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(fpkmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
sceset <- calculateQCMetrics(sceset)
# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, "yan.rds")
