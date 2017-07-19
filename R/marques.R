# mouse juvenile & adult oligodendrocytes
# Marques et al. (2016) Oligodendrocyte heterogeneity in the mouse juvenile and adult central nervous system. 352(6291) 1326-1329 DOI: 10.1126/science.aaf6463

# Human
x1 = read.delim("GSE75330_Marques_et_al_mol_counts2.tab", "\t", header=T, stringsAsFactors=FALSE)
ann <-read.table("Marq_Ann.txt", header=T, stringsAsFactors=FALSE)
rownames(x1) <- x1[,1];
x1 <- x1[,-1];
x1 <- x1[, colnames(x1) %in% colnames(ann)]
ann <- ann[, colnames(ann) %in% colnames(x1)]


x1 <- x1[,order(colnames(x1))]
ann<-ann[order(ann[,2]),]

SOURCE <- as.character(unlist(ann[2,]))
#BATCH <- as.character(unlist(ann[,4]))
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

require("scater")
pd <- new("AnnotatedDataFrame", data=ANN)
marques <- newSCESet(countData=DATA, phenoData=pd, logExprsOffset=1, lowerDetectionLimit=1);
fData(marques)$feature_symbol <- rownames(DATA)
saveRDS(marques, file="marques.rds")
