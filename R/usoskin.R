library(scater)

# load data
d <- read.csv("Usoskin+et+al.+External+resources+Table+1.csv", stringsAsFactors = F)

exprs_data <- data.matrix(d[11:nrow(d), 10:ncol(d)])
ann <- t(d[c(1:3, 5:8), 10:ncol(d)])
colnames(ann) <- d[c(1:3, 5:8), 9]
colnames(ann)[5:7] <- c("cell_type1", "cell_type2", "cell_type3")

# filter bad cells
filt <- !grepl("Empty well", ann[,5]) &
    !grepl("NF outlier", ann[,5]) &
    !grepl("TH outlier", ann[,5]) &
    !grepl("NoN outlier", ann[,5]) &
    !grepl("NoN", ann[,5]) &
    !grepl("Central, unsolved", ann[,5]) &
    !grepl(">1 cell", ann[,5]) &
    !grepl("Medium", ann[,5])

colnames(exprs_data) <- rownames(ann)
rownames(exprs_data) <- d[11:nrow(d), 1]

ann <- ann[filt,]
exprs_data <- exprs_data[,filt]

pd <- new("AnnotatedDataFrame", data = as.data.frame(ann))

# create scater object
usoskin <- newSCESet(fpkmData = exprs_data, phenoData = pd, logExprsOffset = 1)
usoskin <- calculateQCMetrics(usoskin)

# use gene names as feature symbols
usoskin@featureData@data$feature_symbol <- featureNames(usoskin)

# save data
saveRDS(usoskin, file = "usoskin.rds")


