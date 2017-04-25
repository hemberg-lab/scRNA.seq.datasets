library(scater)

# load data
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

# load metadata
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


# create scater object
pd <- new("AnnotatedDataFrame", data = ann_col)

# rpkms
sceset_rpkms <- newSCESet(fpkmData = as.matrix(rpkms), phenoData = pd, logExprsOffset = 1)
sceset_rpkms <- calculateQCMetrics(sceset_rpkms)
# use gene names as feature symbols
sceset_rpkms@featureData@data$feature_symbol <- featureNames(sceset_rpkms)
saveRDS(sceset_rpkms, "tasic-rpkms.rds")

# reads
sceset_reads <- newSCESet(countData = as.matrix(reads), phenoData = pd)
ercc <- featureNames(sceset_reads)[grepl("ERCC-", featureNames(sceset_reads))]
sceset_reads <- calculateQCMetrics(sceset_reads, feature_controls = list(ERCC = ercc))
# use gene names as feature symbols
sceset_reads@featureData@data$feature_symbol <- featureNames(sceset_reads)
saveRDS(sceset_reads, "tasic-reads.rds")
