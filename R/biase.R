library(scater)

# load data
d <- read.table("data.txt", header = T)
d <- d[!duplicated(d$ID),]
rownames(d) <- d$ID
d <- d[,2:ncol(d)]

# cell annotations
ann <- read.table("biase_cell_types.txt", stringsAsFactors = F)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
biase <- newSCESet(fpkmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
biase <- calculateQCMetrics(biase)

# convert ensembl ids into gene names
# gene symbols will be stored in the feature_symbol column of fData
biase <- getBMFeatureAnnos(
    biase, filters="ensembl_gene_id",
    biomart="ensembl", dataset="mmusculus_gene_ensembl")

# save data
saveRDS(biase, "biase.rds")
