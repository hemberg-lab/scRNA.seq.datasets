# Human cerebral organoids + fetal neocortex
# SMARTer
# Camp JG, Badsha F, Florio M, Kanton S et al. Human cerebral organoids recapitulate gene expression programs of fetal neocortex development. Proc Natl Acad Sci U S A 2015 Dec 22;112(51):15672-7. PMID: 26644564
# GSE75140

ann <- read.table("Camp_Neurons_Series_Matrix.txt", header=T)
data <- read.table("GSE75140_hOrg.fetal.master.data.frame.txt", header=T)

dnames <- as.character(data[,1]);
dnames <- strsplit(dnames, "_")
dnames <- lapply(dnames, function(x) { paste(sort(x), collapse="_")})
dnames <- unlist(dnames)

rownames(data) <- dnames;
data <- data[,-1]
data <- data[,-1*length(data[1,])]

anames <- colnames(ann);
anames <- strsplit(anames, "_")
anames <- lapply(anames, function(x) { paste(sort(x[2:length(x)]), collapse="_")})
anames <- unlist(anames)

anames[anames=="13wpc_F5_fetal"] = "12wpc_c1_F5_fetal"

colnames(ann) <- anames

data <- t(data)
data <- data[,order(colnames(data))]
ann <- ann[,order(colnames(ann))]
ann <- t(ann)
# Using reported markers AUC > 0.85 from paper supplementary table

Neuron_Score <- colSums(data[rownames(data) %in% c("DCX","MLLT11","STMN2","SOX4","MYT1L"),])-colSums(data[rownames(data) %in% c("ZFP36L1","VIM"),])
is.neuron = Neuron_Score > 30

Mesenchyme_Score <- colSums(data[rownames(data) %in% c("COL3A1","LUM","S100A11","DCN","IFITM3","COL1A2","SPARC","COL1A2","COL1A1","FTL", "ANXA2","LGALS1","MFAP4"),])
is.mesenchyme = Mesenchyme_Score > 90

dorsal_cortex_progenitors_score <- colSums(data[rownames(data) %in% c("C1orf61", "FABP7","CREB5","GLI3"),])
is.dcp <- dorsal_cortex_progenitors_score > 27

dorsal_cortex_neuron_score <- colSums(data[rownames(data) %in% c("NFIA","NFIB","ABRACL","NEUROD6","CAP2"),])
is.dcn <- dorsal_cortex_neuron_score > 25

ventral_progenitors_score <- colSums(data[rownames(data) %in% c("MTRNR2L12","MDK","BCAT1","PRTG","MGST1","DLK1","IGDCC3"),]) - colSums(data[rownames(data) %in% c("NFIB","NFIA","TUBB","IFI44L","PHLDA1","CREB5"),])
is.vp <- ventral_progenitors_score >20

RSPO_score <- colSums(data[rownames(data) %in% c("WLS","TPBG"),])
# indistinct

Type = rep("Unknown", times=length(ann[,1]))
Type[is.neuron] <- "neuron"
Type[is.mesenchyme] <- "mesenchyme"
Type[is.dcn] <- "dosal cortex neuron"
Type[is.dcp] <- "dosal cortex progenitor"
Type[is.vp] <- "ventral progenitor"

ANN <- data.frame(Species=ann[,2], cell_type1=Type, Source=ann[,4], age=ann[,3], batch=ann[,1])
rownames(ANN) <- rownames(ann)


require("scater")
pd <- new("AnnotatedDataFrame", data=ANN)
camp_neuro <- newSCESet(exprsData=as.matrix(data), phenoData=pd, logExprsOffset=1, lowerDetectionLimit=0);
fData(camp_neuro)$feature_symbol <- featureNames(camp_neuro)
saveRDS(camp_neuro, file="camp_neurons.rds")
