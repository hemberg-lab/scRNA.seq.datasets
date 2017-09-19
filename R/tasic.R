### DATA
rpkms <- read.csv("genes_rpkm.csv")
rownames(rpkms) <- rpkms[,1]
rpkms <- rpkms[,2:ncol(rpkms)]
reads <- read.csv("genes_counts.csv")
rownames(reads) <- reads[,1]
reads <- reads[,2:ncol(reads)]
erccs <- read.csv("ercc_counts.csv")
rownames(erccs) <- erccs[,1]
erccs <- erccs[,2:ncol(erccs)]
reads <- rbind(reads, erccs)

### ANNOTATIONS
ann_col <- read.csv("cell_metadata.csv")
cell_classification <- read.csv("cell_classification.csv")
cluster_metadata <- read.csv("cluster_metadata.csv")
# process metadata
cluster_metadata <- cluster_metadata[,1:(ncol(cluster_metadata) - 1)]
ann_col <- cbind(ann_col, cell_classification[,2:3])
colnames(ann_col)[ncol(ann_col)] <- "cluster_id"
ann_col <- merge(ann_col, cluster_metadata, by = "cluster_id")
ann_col <- ann_col[order(ann_col$long_name), ]
rownames(ann_col) <- ann_col$long_name
ann_col <- ann_col[,c(1, 3:ncol(ann_col))]
# manually define cell types
colnames(ann_col)[grep("group", colnames(ann_col))] <- "cell_type1"
colnames(ann_col)[grep("Tasic_et_al_2016_label", colnames(ann_col))] <- "cell_type2"

### SINGLECELLEXPERIMENT
source("../utils/create_sce.R")
sceset <- create_sce_from_normcounts(rpkms, ann_col)
saveRDS(sceset, "tasic-rpkms.rds")
sceset <- create_sce_from_counts(reads, ann_col)
saveRDS(sceset, "tasic-reads.rds")
