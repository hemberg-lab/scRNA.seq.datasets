library(SingleCellExperiment)
library(scater)

create_sce_from_counts <- function(counts, colData, rowData = NULL) {
    if(is.null(rowData)) {
        sceset <- SingleCellExperiment(assays = list(counts = as.matrix(counts)), 
                                       colData = colData)
    } else {
        sceset <- SingleCellExperiment(assays = list(counts = as.matrix(counts)), 
                                       colData = colData,
                                       rowData = rowData)
    }
    # this function writes to logcounts slot
    exprs(sceset) <- log2(calculateCPM(sceset, use.size.factors = FALSE) + 1)
    # use gene names as feature symbols
    rowData(sceset)$feature_symbol <- rownames(sceset)
    # remove features with duplicated names
    if(is.null(rowData)) {
        sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
    }
    # QC
    isSpike(sceset, "ERCC") <- grepl("^ERCC-", rownames(sceset))
    sceset <- calculateQCMetrics(sceset, feature_controls = list("ERCC" = isSpike(sceset, "ERCC")))
    return(sceset)
}

create_sce_from_normcounts <- function(normcounts, colData, rowData = NULL) {
    if(is.null(rowData)) {
        sceset <- SingleCellExperiment(assays = list(normcounts = as.matrix(normcounts)), 
                                       colData = colData)
    } else {
        sceset <- SingleCellExperiment(assays = list(normcounts = as.matrix(normcounts)), 
                                       colData = colData,
                                       rowData = rowData)
    }
    logcounts(sceset) <- log2(normcounts(sceset) + 1)
    # use gene names as feature symbols
    rowData(sceset)$feature_symbol <- rownames(sceset)
    # remove features with duplicated names
    if(is.null(rowData)) {
        sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
    }
    return(sceset)
}

create_sce_from_logcounts <- function(logcounts, colData, rowData = NULL) {
    if(is.null(rowData)) {
        sceset <- SingleCellExperiment(assays = list(logcounts = as.matrix(logcounts)), 
                                       colData = colData)
    } else {
        sceset <- SingleCellExperiment(assays = list(logcounts = as.matrix(logcounts)), 
                                       colData = colData,
                                       rowData = rowData)
    }
    # use gene names as feature symbols
    rowData(sceset)$feature_symbol <- rownames(sceset)
    # remove features with duplicated names
    if(is.null(rowData)) {
        sceset <- sceset[!duplicated(rowData(sceset)$feature_symbol), ]
    }
    return(sceset)
}
