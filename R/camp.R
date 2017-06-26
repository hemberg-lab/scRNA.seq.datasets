library(scater)

# iPS = induced pluripotent stem cells (day 0)
# HE = hepatic endoderm (day 8)
# LB = liver bud = hepatic endoderm + supportive mesenchymal and endothelial cells
# MH = mature hepatocyte-like (day 21)
# DE = definitive endoderm (day 6)
# IH = immature hepatoblast-like (day 14)
# EC = endothelial cells
# HUVEC = human umbilical vein endothelial cells
# msc = mesenchymal stem cell


x1 = read.delim("GSE81252_data.cast.log2.lineage.csv", sep=",", stringsAsFactors=FALSE)
rownames(x1) <- x1[,1]
experiment1 <- x1[,2]
x1 <- x1[,-c(1,2)]
x1 <- t(x1)

x2 = read.delim("GSE81252_data.cast.log2.liverbud.csv", sep=",", stringsAsFactors=FALSE)
rownames(x2) <- x2[,1]
experiment2 <- x2[,2]
assignment2 <- x2[,3]
x2 <- x2[,-c(1,2,3)]
x2 <- t(x2)

ann = read.table("GSE81252_Ann.txt", header=T, stringsAsFactors=FALSE)
tmp <- colnames(ann)
tmp <- matrix(unlist(strsplit(tmp, "_")), ncol=2, byrow=T)
fixed_names <- paste(tmp[,2], tmp[,1], sep="_")
colnames(ann) <- fixed_names
ann <- t(ann)
# Check duplicate cells
dups <- which(colnames(x1) %in% colnames(x2))
for (i in colnames(x1)[dups]) {
        if (sum(x2[,colnames(x2) == i] == x1[,colnames(x1) == i]) != 19020) {
                print(i);
        }
} 

x1 <- x1[,-dups]
experiment1 <- experiment1[-dups];
MAT <- cbind(x1,x2);


Stage <- c(experiment1, experiment2)
Type <- c(experiment1, assignment2);
Type[grepl("ih",Type)] <- "immature hepatoblast"
Type[grepl("mh",Type)] <- "mature hepatocyte"
Type[grepl("de",Type)] <- "definitive endoderm"
Type[grepl("EC",Type)] <- "endothelial"
Type[grepl("HE",Type)] <- "hepatic endoderm"
Type[grepl("MC",Type)] <- "mesenchymal stem cell"

Source1 <- rep("iPSC line TkDA3-4", times=length(experiment1))
Source2 <- rep("iPSC line TkDA3-4", times=length(experiment2));
Source2[experiment2 == "huvec"] = "HUVEC"
Source2[grepl("lb", experiment2)] = "liver bud"
Source2[grepl("msc", experiment2)] = "Mesenchymal stem cell"
Source <- c(Source1, Source2)
Age <- Stage
Age[Age == "de"] <- "6 days"
Age[Age == "ipsc"] <- "0 days"
Age[grepl("mh", Age)] <- "21 days"
Age[grepl("he", Age)] <- "8 days"
Age[grepl("lb", Age)] <- "liver bud"
Age[grepl("ih", Age)] <- "14 days"
Age[grepl("msc", Age)] <- "msc"
Batch <- Stage
Batch[grepl("lb1", Batch)] = "3"
Batch[grepl("lb2", Batch)] = "4"
Batch[grepl("lb3", Batch)] = "5"
Batch[grepl("lb4", Batch)] = "6"
Batch[grepl("lb5", Batch)] = "7"
Batch[grepl("lb6", Batch)] = "8"
Batch[grepl("1", Batch)] = "1"
Batch[grepl("2", Batch)] = "2"
Batch[grepl("de", Batch)] = "9"
Batch[grepl("ipsc", Batch)] = "10"
Batch[grepl("huvec", Batch)] = "11"
ANN <- data.frame(Species = rep("Homo sapiens", times=length(Stage)), cell_type1 = Type, Source = Source, age = Age, batch=Batch)
rownames(ANN) <- colnames(MAT)

pd <- new("AnnotatedDataFrame", data=ANN)
sceset <- newSCESet(exprsData=as.matrix(MAT), phenoData=pd, logExprsOffset=1, lowerDetectionLimit=0 )
sceset <- calculateQCMetrics(sceset)
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, "camp.rds")
