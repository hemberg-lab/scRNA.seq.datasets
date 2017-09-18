### DATA
# Human
x1 = read.delim("GSE75330_Marques_et_al_mol_counts2.tab", "\t", header=T, stringsAsFactors=FALSE)
ann <-read.table("Marq_Ann.txt", header=T, stringsAsFactors=FALSE)
rownames(x1) <- x1[,1];
x1 <- x1[,-1];
x1 <- x1[, colnames(x1) %in% colnames(ann)]

### ANNOTATIONS
ann <- ann[, colnames(ann) %in% colnames(x1)]
x1 <- x1[,order(colnames(x1))]
ann<-ann[order(ann[,2]),]
SOURCE <- as.character(unlist(ann[2,]))
TYPE <- as.character(unlist(ann[7,]))
AGE <- as.character(unlist(ann[5,]))
STRAIN <- as.character(unlist(ann[6,]))
STATE <- as.character(unlist(ann[4,]))
SEX <- as.character(unlist(ann[1,]))
stuff <- matrix(unlist(strsplit(colnames(ann), "\\.")), ncol=4, byrow=T)
WELL <- stuff[,4]
DATA = x1;
ANN <- data.frame(Species=rep("Mus musculus", times=length(TYPE)), cell_type1=TYPE, Source=SOURCE, age=AGE, WellID=WELL, Strain=STRAIN, State=STATE, sex=SEX)
rownames(ANN) <- colnames(x1)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_counts(DATA, ANN)
saveRDS(sceset, file="marques.rds")
