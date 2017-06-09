library(scater)

args <- commandArgs(trailingOnly = TRUE)

file <- args[1]

sceset <- readRDS(paste0("scater-objects/", file))

# remove features with duplicated names
sceset <- sceset[!duplicated(sceset@featureData@data$feature_symbol), ]

saveRDS(sceset, paste0("scater-objects/", file))
