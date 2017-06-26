library(scater)

# load the data
d <- read.table("pancreas_refseq_rpkms_counts_3514sc.txt", stringsAsFactors = F)
d <- d[!duplicated(d[,1]), ]
rownames(d) <- d[,1]
d <- d[,3:ncol(d)]
d <- d[,3515:7028]
labs <- read.table("labels.txt", stringsAsFactors = F, header = F)
labs <- as.character(labs)
colnames(d) <- labs
d <- d[,order(colnames(d))]
# remove eGFP row
d <- d[1:(nrow(d) - 1), ]

# load the metadata
ann <- read.table("E-MTAB-5061.sdrf.txt", stringsAsFactors = F, header = T, sep = "\t")
rownames(ann) <- ann$Extract.Name
ann <- ann[order(rownames(ann)), ]
ann <- ann[,7:11]
colnames(ann) <- c("cell_quality", "cell_type1", "disease", "sex", "age")
# format cell type names
ann$cell_type1 <- unlist(lapply(strsplit(ann$cell_type1, " cell"), "[[", 1))

# create a scater object
pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(countData = as.matrix(d), phenoData = pd)
ercc <- featureNames(sceset)[grepl("ERCC_", featureNames(sceset))]
sceset <- calculateQCMetrics(sceset, feature_controls = list(ERCC = ercc))
# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, "segerstolpe.rds")
