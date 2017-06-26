library(scater)

d <- read.table("NBT_hiseq_linear_tpm_values.txt")

cell_type1 <- colnames(d)
cell_type1[grepl("Hi_2338", cell_type1)] <- "2338"
cell_type1[grepl("Hi_2339", cell_type1)] <- "2339"
cell_type1[grepl("Hi_K562", cell_type1)] <- "K562"
cell_type1[grepl("Hi_BJ", cell_type1)] <- "BJ"
cell_type1[grepl("Hi_HL60", cell_type1)] <- "HL60"
cell_type1[grepl("Hi_iPS", cell_type1)] <- "hiPSC"
cell_type1[grepl("Hi_Kera", cell_type1)] <- "Kera"
cell_type1[grepl("Hi_GW21.2", cell_type1)] <- "GW21+3"
cell_type1[grepl("Hi_GW21", cell_type1)] <- "GW21"
cell_type1[grepl("Hi_NPC", cell_type1)] <- "NPC"
cell_type1[grepl("Hi_GW16", cell_type1)] <- "GW16"

cell_type2 <- colnames(d)
cell_type2[grepl("Hi_K562", cell_type2) | grepl("Hi_HL60", cell_type2) | 
               grepl("Hi_2339", cell_type2)] <- "blood"
cell_type2[grepl("Hi_BJ", cell_type2) | grepl("Hi_Kera", cell_type2) | 
               grepl("Hi_2338", cell_type2)] <- "dermal"
cell_type2[grepl("Hi_iPS", cell_type2)] <- "pluripotent"
cell_type2[grepl("Hi_GW21.2", cell_type2) | grepl("Hi_GW21", cell_type2) | 
               grepl("Hi_NPC", cell_type2) | grepl("Hi_GW16", cell_type2)] <- "neural"

ann <- data.frame(cell_type1 = cell_type1, cell_type2 = cell_type2)
rownames(ann) <- colnames(d)

pd <- new("AnnotatedDataFrame", data = ann)
sceset <- newSCESet(tpmData = as.matrix(d), phenoData = pd, logExprsOffset = 1)
sceset <- calculateQCMetrics(sceset)
# use gene names as feature symbols
fData(sceset)$feature_symbol <- featureNames(sceset)

# remove features with duplicated names
sceset <- sceset[!duplicated(fData(sceset)$feature_symbol), ]

saveRDS(sceset, "pollen.rds")

