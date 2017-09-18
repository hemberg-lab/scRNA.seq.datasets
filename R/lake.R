### DATA
# http://genome-tech.ucsd.edu/ZhangLab/index.php/data/epigenomics-and-transcriptomics/sns/
# Lake et al. (2016) Neuronal subtypes and diversity revealed by single-nucleus RNA sequencing of the human brain. Science. 352 (6293): 1586-1590
# Own website
#Prefrontal cortex - BA10
#Frontal cortex (eye fields) - BA8
#Auditory cortex (speech) - BA21
#Auditory cortex (Wernicke's area) - BA22
#Auditory cortex - BA41/42
#Visual cortex - BA17
# Problems: duplicate row names
# Human
x1 = read.delim("Lake-2016_Gene_TPM.dat", "\t", header=F, stringsAsFactors=FALSE)
ann <- read.table("Lake-2016_Gene_TPM_Sample-annotation.txt", header=T)
gene_names <- x1[,1]
cell_names <- x1[1,]
cell_names <- as.character(unlist(cell_names))
cell_names <- cell_names[-1]
gene_names <- gene_names[-1]
x1 <- x1[-1,-1]
# not log-transformed tpms
exclude = duplicated(gene_names)
keep_cells = cell_names %in% ann[,2]
x1 <- x1[,keep_cells]
cell_names <- cell_names[keep_cells]
colnames(x1) <- cell_names;
reorder <- order(colnames(x1))
x1 <- x1[,reorder]

### ANNOTATIONS
ann <- ann[ann[,2] %in% colnames(x1),]
ann<-ann[order(ann[,2]),]
SOURCE <- as.character(unlist(ann[,4]))
BATCH <- as.character(unlist(ann[,4]))
SOURCE[SOURCE=="BA10"] = "Prefrontal cortex"
SOURCE[SOURCE=="BA8"] = "Frontal cortex"
SOURCE[SOURCE=="BA21"] = "Auditory cortex (speech)"
SOURCE[SOURCE=="BA22"] = "Auditory cortex (Wernicke)"
SOURCE[SOURCE=="BA41"] = "Auditory cortex"
SOURCE[SOURCE=="BA17"] = "Visual cortex"
TYPE <- as.character(unlist(ann[3]))
AGE <- rep("51yo", times=length(BATCH))
stuff <- sub( "_S.+","", colnames(x1));
stuff <- matrix(unlist(strsplit(stuff, "_")), ncol=2, byrow=T)
WELL <- stuff[,2]
PLATE <- stuff[,1]
DATA <- apply(x1, 1, as.numeric)
DATA<- t(DATA)
colnames(DATA) <- colnames(x1)
rownames(DATA) <- rownames(x1)
ANN <- data.frame(Species=rep("Homo sapiens", times=length(TYPE)), cell_type1=TYPE, Source=SOURCE, age=AGE, WellID=WELL, batch=BATCH, Plate=PLATE)
rownames(ANN) <- colnames(x1)

### SINGLECELLEXPERIMENT
source("utils/create_sce.R")
sceset <- create_sce_from_normcounts(DATA, ANN)
saveRDS(sceset, file="lake.rds")
