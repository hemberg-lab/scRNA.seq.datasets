library(scater)

# read data
d <- read.table("data.txt")

# select 5 patients
d <- d[,grepl("MGH26_", colnames(d)) |
       grepl("MGH264_", colnames(d)) |
       grepl("MGH28_", colnames(d)) |
       grepl("MGH29_", colnames(d)) |
       grepl("MGH30_", colnames(d)) |
       grepl("MGH31_", colnames(d))]

# create phenodata
patients <- unlist(lapply(strsplit(colnames(d), "_"), "[[", 1))
patients[patients == "MGH264"] <- "MGH26"
ann <- data.frame(patients = patients)
rownames(ann) <- colnames(d)
pd <- new("AnnotatedDataFrame", data = ann)

# create scater object
sceset <- newSCESet(exprsData = d, phenoData = pd)

# QC was not calculated since the data is heavily normalised

# save the data
saveRDS(sceset, file = "patel.rds")

print(sceset)
