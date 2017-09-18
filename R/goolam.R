### DATA
d <- read.table("Goolam_et_al_2015_count_table.tsv", header = T)

### ANNOTATIONS
labs <- colnames(d)
labs[grep("4cell",labs)] = "4cell"
labs[grep("8cell",labs)] = "8cell"
labs[grep("16cell",labs)] = "16cell"
labs[grep("32cell",labs)] = "blast"
labs[grep("2cell",labs)] = "2cell"
ann <- data.frame(cell_type1 = labs)
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
saveRDS(sceset, "goolam.rds")
