library(scater)

# load data
d <- read.table("nature13173-s4.txt")
d <- t(d)

genes <- d[,1][5:nrow(d)]
# remove genes and bulk samples
d <- d[,2:(ncol(d) - 2)]

exprs_data <- matrix(as.numeric(d[5:nrow(d),]), ncol = ncol(d))
rownames(exprs_data) <- genes
colnames(exprs_data) <- d[1,]

ann <- data.frame(cell_type1 = d[4,])
rownames(ann) <- d[1,]
pd <- new("AnnotatedDataFrame", data = ann)

treutlein <- newSCESet(fpkmData = exprs_data, phenoData = pd)

# run quality controls
is_exprs(treutlein) <- exprs(treutlein) > 0
treutlein <- calculateQCMetrics(treutlein)

# save the data
saveRDS(treutlein, file = "treutlein.rds")
