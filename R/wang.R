### DATA
x <- read.table("GSE83139_tbx-v-f-norm-ntv-cpms.csv", header=T, stringsAsFactor=FALSE)
fDat <- x[,1:7]
x<-x[,-1*c(1:7)]
rownames(x) <- fDat$transcript
rownames(x)[!is.na(fDat$gene)] <- fDat$gene[!is.na(fDat$gene)]
rownames(fDat) <- rownames(x)

### ANNOTATIONS
ann1 <- read.delim("GSE83139-GPL11154_series_matrix.txt",sep="\n", header=F, stringsAsFactor=FALSE)
ANN1 <- ann1[c(38,48:50),]
ANN1 <- sapply(ANN1, function(y){strsplit(y, "\t")})
ann2 <- read.delim("GSE83139-GPL16791_series_matrix.txt",sep="\n", header=F, stringsAsFactor=FALSE)
ANN2 <- ann2[c(38,48:50),]
ANN2 <- sapply(ANN2, function(y){strsplit(y, "\t")})
# Extract metadata
qualities <- list()
for (i in 1:length(ANN1)) {
        thing1 <- ANN1[[i]]
        thing1 <- thing1[-1]
        thing1 <- matrix(unlist(strsplit(thing1, " ")), ncol=2, byrow=T)
        thing2 <- ANN2[[i]]
        thing2 <- thing2[-1]
        thing2 <- matrix(unlist(strsplit(thing2, " ")), ncol=2, byrow=T)
        qualities[[i]] = c(thing1[,2], thing2[,2])
}
pDat <- data.frame(age=qualities[[2]], disease=qualities[[3]], cell_type1=qualities[[4]])
rownames(pDat) = paste("reads.", qualities[[1]], sep="")
# Check cell ordering
pDat<-pDat[order(rownames(pDat)),]
if (sum(rownames(pDat)==colnames(x)) < length(colnames(x))) {stop("Cell Ordering Doesn't Match")}
pDat$cell_type1 <- as.character(pDat$cell_type1)
pDat$cell_type1[pDat$cell_type1 == "pp"] <- "gamma"
pDat$cell_type1[pDat$cell_type1 == "duct"] <- "ductal"


### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_normcounts(x, pDat, fDat)
saveRDS(sceset, "wang.rds")
