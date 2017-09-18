### DATA
deng_rpkms <- read.table("deng-rpkms.txt", check.names = F, header = T)
deng_reads <- read.table("deng-reads.txt", check.names = F, header = T)
genes <- deng_rpkms[ , 1]
deng_rpkms <- as.matrix(deng_rpkms[ , 2:ncol(deng_rpkms)])
rownames(deng_rpkms) <- genes
deng_reads <- as.matrix(deng_reads[ , 2:ncol(deng_reads)])
rownames(deng_reads) <- genes
cell_ids <- colnames(deng_rpkms)

### ANNOTATIONS
labs <- unlist(lapply(strsplit(cell_ids, "\\."), "[[", 1))
ann <- data.frame(cell_type2 = labs)
labs[labs == "zy" | labs == "early2cell"] = "zygote"
labs[labs == "mid2cell" | labs == "late2cell"] = "2cell"
labs[labs == "earlyblast" | labs == "midblast" | labs == "lateblast"] = "blast"
ann$cell_type1 <- labs
rownames(ann) <- cell_ids

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
deng_reads <- create_sce_from_counts(deng_reads, ann)
deng_rpkms <- create_sce_from_normcounts(deng_rpkms, ann)
saveRDS(deng_rpkms, "deng-rpkms.rds")
saveRDS(deng_reads, "deng-reads.rds")
