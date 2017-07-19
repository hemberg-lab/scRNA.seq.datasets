# Mouse brain
# Romanov et al. (2017) Molecular interrogation of hypothalamic organization reveals distinct dopamine neuronal subtypes. Nat Neuroscience. 20(2):176-188 PMID: 27991900
# GSE74672
# xlsx file - why would you do that?
# Mouse

x1 = read.delim("Romanov_hypoth_moldata.csv", ",", header=T, stringsAsFactors=FALSE)
ann <-x1[1:11,]
x1 <- x1[-1*(1:11),]
rownames(x1) <- x1[,1];
x1 <- x1[,-1];

tmp <- ann[,1]
ann <- ann[,-1]

SOURCE <- rep("hypothalamus", times=length(x1[1,]))
#BATCH <- as.character(unlist(ann[,4]))
TYPE1 <- as.character(unlist(ann[1,]))
TYPE2 <- as.character(unlist(ann[2,]))
TYPE3 <- as.character(unlist(ann[3,]))
AGE <- as.character(unlist(ann[4,]))
STATE <- as.character(unlist(ann[7,]))
SEX <- as.character(unlist(ann[5,]))
SEX[SEX == -1] = "M"
SEX[SEX == 1] = "F"
SEX[SEX == 0] = "?"
STATE[STATE==1] = "Stressed"
STATE[STATE==0] = "Normal"

stuff <- matrix(unlist(strsplit(colnames(ann), "_")), ncol=2, byrow=T)
WELL <- stuff[,2]
PLATE=stuff[,1]


DATA = apply(x1,2,as.numeric);
rownames(DATA) = rownames(x1)
colnames(DATA) = colnames(x1);

ANN <- data.frame(Species=rep("Mus musculus", times=length(TYPE1)), cell_type1=TYPE1, cell_type2=TYPE2, clusterID=TYPE3, Source=SOURCE, age=AGE, WellID=WELL, State=STATE, sex=SEX, Plate=PLATE, WellID=WELL)
rownames(ANN) <- colnames(x1)

require("scater")
pd <- new("AnnotatedDataFrame", data=ANN)
romanov<- newSCESet(countData=DATA, phenoData=pd, logExprsOffset=1, lowerDetectionLimit=1);
fData(romanov)$feature_symbol <- rownames(DATA)
saveRDS(romanov, file="romanov.rds")
