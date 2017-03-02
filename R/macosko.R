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

# create scater object
sceset <- newSCESet(countData = macosko, phenoData = pd)
sceset <- calculateQCMetrics(sceset)
sceset@featureData@data$feature_symbol <- featureNames(sceset)

# save data
saveRDS(sceset, file = "macosko.rds")


# 
# # load data
# tab5rows <-
#     read.table("data1.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d1 <- read.table("data1.txt",
#                  header = TRUE, colClasses = classes, nrow = 20479)
# labs1 <- d1[,1]
# 
# tab5rows <-
#     read.table("data2.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d2 <- read.table("data2.txt",
#                  header = TRUE, colClasses = classes, nrow = 20620)
# labs2 <- d2[,1]
# 
# tab5rows <-
#     read.table("data3.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d3 <- read.table("data3.txt",
#                  header = TRUE, colClasses = classes, nrow = 20170)
# labs3 <- d3[,1]
# 
# tab5rows <-
#     read.table("data4.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d4 <- read.table("data4.txt",
#                  header = TRUE, colClasses = classes, nrow = 20240)
# labs4 <- d4[,1]
# 
# tab5rows <-
#     read.table("data5.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d5 <- read.table("data5.txt",
#                  header = TRUE, colClasses = classes, nrow = 19720)
# labs5 <- d5[,1]
# 
# tab5rows <-
#     read.table("data6.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d6 <- read.table("data6.txt",
#                  header = TRUE, colClasses = classes, nrow = 20648)
# labs6 <- d6[,1]
# 
# tab5rows <-
#     read.table("data7.txt",
#                header = TRUE, nrows = 5)
# classes <- sapply(tab5rows, class)
# d7 <- read.table("data7.txt",
#                  header = TRUE, colClasses = classes, nrow = 20106)
# labs7 <- d7[,1]
# 
# # number of genes in each file is different - find genes common to all files
# labs.all <- labs1[labs1 %in% labs2 &
#                       labs1 %in% labs3 &
#                       labs1 %in% labs4 &
#                       labs1 %in% labs5 &
#                       labs1 %in% labs6 &
#                       labs1 %in% labs7]
# 
# # select only genes from labs.all
# d1 <- d1[d1[ , 1] %in% labs.all, ]
# d2 <- d2[d2[ , 1] %in% labs.all, ]
# d3 <- d3[d3[ , 1] %in% labs.all, ]
# d4 <- d4[d4[ , 1] %in% labs.all, ]
# d5 <- d5[d5[ , 1] %in% labs.all, ]
# d6 <- d6[d6[ , 1] %in% labs.all, ]
# d7 <- d7[d7[ , 1] %in% labs.all, ]
# 
# # make matrices
# d1 <- d1[ , 2:dim(d1)[2]]
# rownames(d1) <- labs.all
# d1 <- as.matrix(d1)
# 
# d2 <- d2[ , 2:dim(d2)[2]]
# rownames(d2) <- labs.all
# d2 <- as.matrix(d2)
# 
# d3 <- d3[ , 2:dim(d3)[2]]
# rownames(d3) <- labs.all
# d3 <- as.matrix(d3)
# 
# d4 <- d4[ , 2:dim(d4)[2]]
# rownames(d4) <- labs.all
# d4 <- as.matrix(d4)
# 
# d5 <- d5[ , 2:dim(d5)[2]]
# rownames(d5) <- labs.all
# d5 <- as.matrix(d5)
# 
# d6 <- d6[ , 2:dim(d6)[2]]
# rownames(d6) <- labs.all
# d6 <- as.matrix(d6)
# 
# d7 <- d7[ , 2:dim(d7)[2]]
# rownames(d7) <- labs.all
# d7 <- as.matrix(d7)
# 
# cols1 <- colnames(d1)
# cols1 <- paste("r1", cols1, sep = "_")
# cols2 <- colnames(d2)
# cols2 <- paste("r2", cols2, sep = "_")
# cols3 <- colnames(d3)
# cols3 <- paste("r3", cols3, sep = "_")
# cols4 <- colnames(d4)
# cols4 <- paste("r4", cols4, sep = "_")
# cols5 <- colnames(d5)
# cols5 <- paste("r5", cols5, sep = "_")
# cols6 <- colnames(d6)
# cols6 <- paste("r6", cols6, sep = "_")
# cols7 <- colnames(d7)
# cols7 <- paste("p1", cols7, sep = "_")
# 
# colnames(d1) <- cols1
# colnames(d2) <- cols2
# colnames(d3) <- cols3
# colnames(d4) <- cols4
# colnames(d5) <- cols5
# colnames(d6) <- cols6
# colnames(d7) <- cols7
# 
# # merge data files
# macosko <- cbind(d1, d2)
# macosko <- cbind(macosko, d3)
# macosko <- cbind(macosko, d4)
# macosko <- cbind(macosko, d5)
# macosko <- cbind(macosko, d6)
# macosko <- cbind(macosko, d7)
# 
# gc()
# 
# # cell labels data file is downloaded from:
# # http://mccarrolllab.com/dropseq/
# cells <- read.table("retina_clusteridentities.txt", stringsAsFactors = F)
# 
# cols <- colnames(macosko)
# cols <- cols[cols %in% cells[,1]]
# 
# macosko <- macosko[ , colnames(macosko) %in% cols]
# 
# cells <- cells[order(cells[,1]),]
# cols <- colnames(macosko)
# macosko <- macosko[ , order(cols)]
# 
# # create scater object
# 
# # remove duplicated genes
# macosko <- macosko[!duplicated(unlist(lapply(strsplit(rownames(macosko), ":"), "[[", 3))), ]
# rownames(macosko) <- unlist(lapply(strsplit(rownames(macosko), ":"), "[[", 3))
# 
# # assign cell types based on the paper
# cells$cell_type1 <- "rods"
# cells$cell_type1[cells[,2] == 1] <- "horizontal"
# cells$cell_type1[cells[,2] == 2] <- "ganglion"
# cells$cell_type1[cells[,2] %in% 3:23] <- "amacrine"
# cells$cell_type1[cells[,2] == 25] <- "cones"
# cells$cell_type1[cells[,2] %in% 26:33] <- "bipolar"
# cells$cell_type1[cells[,2] == 34] <- "muller"
# cells$cell_type1[cells[,2] == 35] <- "astrocytes"
# cells$cell_type1[cells[,2] == 36] <- "fibroblasts"
# cells$cell_type1[cells[,2] == 37] <- "vascular_endothelium"
# cells$cell_type1[cells[,2] == 38] <- "pericytes"
# cells$cell_type1[cells[,2] == 39] <- "microglia"
# 
# rownames(cells) <- cells[,1]
# cells <- cells[,2:3]
# colnames(cells)[1] <- "clust_id"
# 
# pd <- new("AnnotatedDataFrame", data = cells)
# 
# # create scater object
# sceset <- newSCESet(countData = macosko, phenoData = pd)
# sceset <- calculateQCMetrics(sceset)
# sceset@featureData@data$feature_symbol <- featureNames(sceset)
# 
# # save data
# saveRDS(sceset, file = "macosko.rds")
