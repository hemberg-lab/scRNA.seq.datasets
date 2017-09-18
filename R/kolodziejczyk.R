### DATA
d <- read.table("counttable_es.csv")
d <- d[1:(nrow(d) - 5), ]

### ANNOTATIONS
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

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_counts(d, ann)
# convert ensembl ids into gene names
# gene symbols will be stored in the feature_symbol column of fData
sceset <- getBMFeatureAnnos(
    sceset, filters="ensembl_gene_id",
    biomart="ensembl", dataset="mmusculus_gene_ensembl")
# remove features with duplicated names
sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
saveRDS(sceset, "kolodziejczyk.rds")
