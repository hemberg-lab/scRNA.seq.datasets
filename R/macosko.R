library(scater)

d <- read.table("data.txt", header = TRUE, stringsAsFactors = FALSE)

# convert gene names to proper ones
genes <- data.frame(genes = d[,1])
# gene proper gene names from Ensembl Biomart
real_genes <- read.table("mart_export.txt", header=T)
real_genes$genes <- toupper(real_genes$gene_name)
res <- merge(real_genes, genes)
d <- d[d[,1] %in% res$genes, ]
d <- d[order(d[,1]), ]
res <- res[order(res$genes), ]
res <- res[!duplicated(res$genes), ]
rownames(d) <- res$gene_name
d <- d[,2:ncol(d)]

# cell labels data file is downloaded from:
# http://mccarrolllab.com/dropseq/
cells <- read.table("retina_clusteridentities.txt", stringsAsFactors = F)

cols <- colnames(d)
cols <- cols[cols %in% cells[,1]]

d <- d[ , colnames(d) %in% cols]

cells <- cells[order(cells[,1]),]
cols <- colnames(d)
d <- d[ , order(cols)]

# create scater object

# assign cell types based on the paper
cells$cell_type1 <- "rods"
cells$cell_type1[cells[,2] == 1] <- "horizontal"
cells$cell_type1[cells[,2] == 2] <- "ganglion"
cells$cell_type1[cells[,2] %in% 3:23] <- "amacrine"
cells$cell_type1[cells[,2] == 25] <- "cones"
cells$cell_type1[cells[,2] %in% 26:33] <- "bipolar"
cells$cell_type1[cells[,2] == 34] <- "muller"
cells$cell_type1[cells[,2] == 35] <- "astrocytes"
cells$cell_type1[cells[,2] == 36] <- "fibroblasts"
cells$cell_type1[cells[,2] == 37] <- "vascular_endothelium"
cells$cell_type1[cells[,2] == 38] <- "pericytes"
cells$cell_type1[cells[,2] == 39] <- "microglia"

rownames(cells) <- cells[,1]
cells <- cells[,2:3]
colnames(cells)[1] <- "clust_id"

pd <- new("AnnotatedDataFrame", data = cells)

gc()

# create scater object
sceset <- newSCESet(countData = d, phenoData = pd)
sceset <- calculateQCMetrics(sceset)
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

# save data
saveRDS(sceset, file = "macosko.rds")
