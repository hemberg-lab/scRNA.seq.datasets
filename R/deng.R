library(scater)

# load data
deng_rpkms <- read.table("deng-rpkms.txt", check.names = F, header = T)
deng_reads <- read.table("deng-reads.txt", check.names = F, header = T)

genes <- deng_rpkms[ , 1]
deng_rpkms <- as.matrix(deng_rpkms[ , 2:ncol(deng_rpkms)])
rownames(deng_rpkms) <- genes
deng_reads <- as.matrix(deng_reads[ , 2:ncol(deng_reads)])
rownames(deng_reads) <- genes

cell_ids <- colnames(deng_rpkms)

# create cell annotations
labs <- unlist(lapply(strsplit(cell_ids, "\\."), "[[", 1))
ann <- data.frame(cell_type1 = labs)
labs[labs == "zy" | labs == "early2cell"] = "zygote"
labs[labs == "mid2cell" | labs == "late2cell"] = "2cell"
labs[labs == "earlyblast" | labs == "midblast" | labs == "lateblast"] = "blast"
ann$cell_type2 <- labs
rownames(ann) <- cell_ids
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
deng_rpkms <- deng_rpkms[!duplicated(rownames(deng_rpkms)), ]
deng_reads <- deng_reads[!duplicated(rownames(deng_reads)), ]
deng_rpkms <- newSCESet(fpkmData = deng_rpkms, phenoData = pd)
deng_reads <- newSCESet(countData = deng_reads, phenoData = pd)

# run quality controls
is_exprs(deng_rpkms) <- exprs(deng_rpkms) > 0
deng_rpkms <- calculateQCMetrics(deng_rpkms)

deng_reads <- calculateQCMetrics(deng_reads)

# use gene names as feature symbols
deng_rpkms@featureData@data$feature_symbol <- featureNames(deng_rpkms)
deng_reads@featureData@data$feature_symbol <- featureNames(deng_reads)

# save files
saveRDS(deng_rpkms, "deng-rpkms.rds")
saveRDS(deng_reads, "deng-reads.rds")
