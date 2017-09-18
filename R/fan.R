### DATA
d1 <- read.table("small_final.txt", header = T)
rownames(d1) <- d1[,1]
d1 <- d1[,2:ncol(d1)]
d2 <- read.table("large_final.txt", header = T)
d2 <- d2[!duplicated(d2[,1]), ]
rownames(d2) <- d2[,1]
d2 <- d2[,2:ncol(d2)]
# merge two tables
d1 <- d1[rownames(d1) %in% rownames(d2), ]
d2 <- d2[rownames(d2) %in% rownames(d1), ]
d1 <- d1[order(rownames(d1)), ]
d2 <- d2[order(rownames(d2)), ]
d <- cbind(d1, d2)

### ANNOTATIONS
ct1 <- colnames(d)
ct1[grep("ocyte",ct1)] = "zygote"
ct1[grep("zygote",ct1)] = "zygote"
ct1[grep("a.AM",ct1)] = "zygote"
ct1[grep("2.cell",ct1)] = "2cell"
ct1[grep("4.cell",ct1)] = "4cell"
ct1[grep("8.cell",ct1)] = "8cell"
ct1[grep("morula",ct1)] = "16cell"
ct1[grep("ICM",ct1)] = "blast"
ct1[grep("TE",ct1)] = "blast"
ct1[grep("blast",ct1)] = "blast"

ct2 <- colnames(d)
ct2[grep("ocyte",ct2)] = "oocyte"
ct2[grep("zygote",ct2)] = "zygote"
ct2[grep("a.AM",ct2)] = "zygote"
ct2[grep("2.cell",ct2)] = "2cell"
ct2[grep("4.cell",ct2)] = "4cell"
ct2[grep("8.cell",ct2)] = "8cell"
ct2[grep("morula",ct2)] = "morula"
ct2[grep("ICM",ct2)] = "ICM"
ct2[grep("TE",ct2)] = "TE"
ct2[grep("blast",ct2)] = "blast"

ann <- data.frame(cell_type1 = ct1, cell_type2 = ct2)
rownames(ann) <- colnames(d)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_normcounts(d, ann)
saveRDS(sceset, "fan.rds")
