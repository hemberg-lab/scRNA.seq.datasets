##### Human

### DATA
fix_name <- function(name){
        tmp <- strsplit(name, "_")
        return(tmp[[1]][1])
}
fix_type <- function(x) {as.numeric(as.character(x))}

x1 = read.delim("GSE76381_ESMoleculeCounts.cef.txt", sep="\t", header=F)
cellid = x1[2,]
celltype1=x1[3,]
timepoint1=x1[4,]
x1 <- x1[-c(1:5),]
rownames(x1)<- x1[,1]
x1<-x1[,-c(1,2)]
colnames(x1) <- as.character(unlist(cellid))[-c(1,2)]
tmp_rownames <- rownames(x1);
x1 <- apply(x1, 2, fix_type)
rownames(x1) <- tmp_rownames
x2 = read.delim("GSE76381_EmbryoMoleculeCounts.cef.txt", sep="\t", header=F)
cellid = x2[2,]
celltype2=x2[3,]
timepoint2=x2[4,]
x2 <- x2[-c(1:5),]
rownames(x2)<- x2[,1]
x2<-x2[,-c(1,2)]
colnames(x2) <- as.character(unlist(cellid))[-c(1,2)]
tmp_rownames <- rownames(x2);
x2 <- apply(x2, 2, fix_type)
rownames(x2) <- tmp_rownames
x3 = read.delim("GSE76381_iPSMoleculeCounts.cef.txt", sep="\t", header=F)
cellid = x3[2,]
celltype3=x3[3,]
timepoint3=x3[4,]
x3 <- x3[-c(1:5),]
rownames(x3)<- x3[,1]
x3<-x3[,-c(1,2)]
colnames(x3) <- as.character(unlist(cellid))[-c(1,2)]
tmp_rownames <- rownames(x3);
x3 <- apply(x3, 2, fix_type)
rownames(x3) <- tmp_rownames

### ANNOTATIONS
all_genes <- sort(unique(c(rownames(x1), rownames(x2), rownames(x3))))
all_symbol <- sapply(all_genes, fix_name)
x1_order <- match(all_genes, rownames(x1))
x1 <- x1[x1_order,]
x1[is.na(x1)] <- 0
x2_order <- match(all_genes, rownames(x2))
x2 <- x2[x2_order,]
x2[is.na(x2)] <- 0
x3_order <- match(all_genes, rownames(x3))
x3 <- x3[x3_order,]
x3[is.na(x3)] <- 0
DATA <- cbind(x1, x2, x3)
rownames(DATA) <- all_genes
TYPE <- c(as.character(unlist(celltype1))[-c(1,2)], as.character(unlist(celltype2))[-c(1,2)], as.character(unlist(celltype3))[-c(1,2)])
AGE <- c(as.character(unlist(timepoint1))[-c(1,2)], as.character(unlist(timepoint2))[-c(1,2)], as.character(unlist(timepoint3))[-c(1,2)])
stuff <- matrix(unlist(strsplit(colnames(DATA), "-|_")), ncol=3, byrow=T)
WELL <- stuff[,3]
SOURCE <- rep(c("ESCs", "ventral midbrain", "iPSCs"), times=c(length(x1[1,]), length(x2[1,]), length(x3[1,])))
ANN <- data.frame(Species=rep("Homo sapiens", times=length(DATA[1,])), cell_type1=TYPE, Source=SOURCE, age=AGE, WellID=WELL, batch=paste(stuff[,1], stuff[,2]))
rownames(ANN) = colnames(DATA)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_counts(DATA, ANN)
saveRDS(sceset, file="manno_human.rds")

##### Mouse

### DATA
m1 = read.delim("GSE76381_MouseAdultDAMoleculeCounts.cef.txt", sep=",", header=F)
cellid = m1[3,]
celltype1=m1[4,]
m1 <- m1[-c(1:5),]
rownames(m1)<- m1[,1]
m1<-m1[,-c(1,2)]
colnames(m1) <- as.character(unlist(cellid))[-c(1,2)]
tmp_rownames <- rownames(m1);
m1 <- apply(m1, 2, fix_type)
rownames(m1) <- tmp_rownames
m2 = read.delim("GSE76381_MouseEmbryoMoleculeCounts.cef.txt", sep="\t", header=F)
cellid = m2[3,]
celltype2=m2[4,]
timepoint2=m2[5,]
m2 <- m2[-c(1:7),]
rownames(m2)<- m2[,1]
m2<-m2[,-c(1,2)]
colnames(m2) <- as.character(unlist(cellid))[-c(1,2)]
tmp_rownames <- rownames(m2);
m2 <- apply(m2, 2, fix_type)
rownames(m2) <- tmp_rownames

### ANNOTATIONS
all_genes <- sort(unique(c(rownames(m1), rownames(m2))))
all_symbol <- sapply(all_genes, fix_name)
m1_order <- match(all_genes, rownames(m1))
m1 <- m1[m1_order,]
m1[is.na(m1)] <- 0
m2_order <- match(all_genes, rownames(m2))
m2 <- m2[m2_order,]
m2[is.na(m2)] <- 0
DATA <- cbind(m1, m2)
rownames(DATA) <- all_genes
TYPE <- c(as.character(unlist(celltype1))[-c(1,2)], as.character(unlist(celltype2))[-c(1,2)])
AGE <- c(rep("adult", times=length(m1[1,])), as.character(unlist(timepoint2))[-c(1,2)])
stuff <- matrix(unlist(strsplit(colnames(DATA), "-|_")), ncol=2, byrow=T)
WELL <- stuff[,2]
SOURCE <- rep(c("substantia nigra-ventral tegmental area","ventral midbrain"), times=c(length(m1[1,]), length(m2[1,])))
ANN <- data.frame(Species=rep("Mus musclus", times=length(DATA[1,])), cell_type1=TYPE, Source=SOURCE, age=AGE, WellID=WELL, batch=stuff[,1])
rownames(ANN) = colnames(DATA)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_counts(DATA, ANN)
saveRDS(sceset, file="manno_mouse.rds")
