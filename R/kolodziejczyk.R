library(scater)

d <- read.table("counttable_es.csv")
d <- d[1:(nrow(d) - 5), ]

# cell annotations
ann <- data.frame(
    cell_type1 = unlist(lapply(strsplit(colnames(d), "_"), "[[", 3)),
    batch = paste(
        unlist(lapply(strsplit(colnames(d), "_"), "[[", 3)),
        unlist(lapply(strsplit(colnames(d), "_"), "[[", 4)),
        sep = "_"
    )
)
rownames(ann) <- colnames(d)
colnames(d) <- rownames(ann)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
sceset <- newSCESet(countData = as.matrix(d), phenoData = pd)
# don't include ERCCs in QC
sceset <- calculateQCMetrics(sceset, feature_controls = grep("ERCC-", rownames(d)))

# convert ensembl ids into gene names
# gene symbols will be stored in the feature_symbol column of fData
sceset <- getBMFeatureAnnos(
    sceset, filters="ensembl_gene_id",
    biomart="ensembl", dataset="mmusculus_gene_ensembl")

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

# save data
saveRDS(sceset, "kolodziejczyk.rds")
