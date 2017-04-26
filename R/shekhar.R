library(scater)

# load data
load("bipolar_data_Cell2016.Rdata")

# Remove libraries that contain more than 10% mitochondrially derived transcripts
mt.genes = grep("mt-", rownames(bipolar_dge), value = TRUE)
cells.use = colnames(bipolar_dge)[colSums(bipolar_dge[mt.genes, ])/colSums(bipolar_dge) < 0.1]
bipolar_dge = bipolar_dge[, cells.use]

# Initialize single cell data as an S4 class object. Only cells where > 500 
# genes are detected are considered.
# Among the selected cells, only genes that are present in > 30 cells and 
# those having > 60 transcripts summed
# across all the selected cells are considered.
bipolar_dge <- bipolar_dge[ , colSums(bipolar_dge > 0) > 500]
bipolar_dge <- bipolar_dge[rowSums(bipolar_dge > 0) > 30 & rowSums(bipolar_dge) > 60, ]

# create cell annotations
# use cluster file from https://portals.broadinstitute.org/single_cell/study/retinal-bipolar-neuron-drop-seq
d <- read.table("clust_retinal_bipolar.txt", sep = "\t", header = T)
cell_ids <- d[,1]
d <- data.frame(cell_type2 = d[,2])
rownames(d) <- cell_ids

# annotation louvain clusters (using Fig.1,F from the paper)
d$clust_id <- NA
d$clust_id[d$cell_type2 == "BC1A"] <- 7
d$clust_id[d$cell_type2 == "BC1B"] <- 9
d$clust_id[d$cell_type2 == "BC2"] <- 10
d$clust_id[d$cell_type2 == "BC3A"] <- 12
d$clust_id[d$cell_type2 == "BC3B"] <- 8
d$clust_id[d$cell_type2 == "BC4"] <- 14
d$clust_id[d$cell_type2 == "BC5A (Cone Bipolar cell 5A)"] <- 3
d$clust_id[d$cell_type2 == "BC5B"] <- 13
d$clust_id[d$cell_type2 == "BC5C"] <- 6
d$clust_id[d$cell_type2 == "BC5D"] <- 11
d$clust_id[d$cell_type2 == "BC6"] <- 5
d$clust_id[d$cell_type2 == "BC7 (Cone Bipolar cell 7)"] <- 4
d$clust_id[d$cell_type2 == "BC8/9 (mixture of BC8 and BC9)"] <- 15
d$clust_id[d$cell_type2 == "RBC (Rod Bipolar cell)"] <- 1
d$clust_id[d$cell_type2 == "MG (Mueller Glia)"] <- 2
d$clust_id[d$cell_type2 == "AC (Amacrine cell)"] <- 16
d$clust_id[d$cell_type2 == "Rod Photoreceptors"] <- 20
d$clust_id[d$cell_type2 == "Cone Photoreceptors"] <- 22

# our manual annotation
d$cell_type1 <- "unknown"
d$cell_type1[grepl("BC", d$cell_type2)] <- "bipolar"
d$cell_type1[grepl("MG", d$cell_type2)] <- "muller"
d$cell_type1[grepl("AC", d$cell_type2)] <- "amacrine"
d$cell_type1[grepl("Rod Photoreceptors", d$cell_type2)] <- "rods"
d$cell_type1[grepl("Cone Photoreceptors", d$cell_type2)] <- "cones"
pd <- new("AnnotatedDataFrame", data = d)

# create scater object
sceset <- newSCESet(countData = bipolar_dge, phenoData = pd)
sceset <- calculateQCMetrics(sceset)
sceset@featureData@data$feature_symbol <- featureNames(sceset)

# save data
saveRDS(sceset, file = "shekhar.rds")
