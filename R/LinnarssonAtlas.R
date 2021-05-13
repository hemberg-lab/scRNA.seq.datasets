require("rhdf5")
require("Matrix")
require("SingleCellExperiment")

files <- Sys.glob("*.loom")

for (loom_file in files) {

        data <- h5read(loom_file,name = "/")

        colnames(data$matrix) <- as.character(data$row_attrs$Accession)
        rownames(data$matrix) <- paste("Cell",1:nrow(data$matrix), sep="")

        data_matrix <- Matrix(t(data$matrix), sparse=T)

        ann <- data.frame(cell_type1=data$col_attrs$Class, cell_type2=data$col_attrs$Subclass, tissue=data$col_attrs$Tissue, cluster=data$col_attrs$Clusters, age=data$col_attrs$Age, sex=data$col_attrs$Sex, batch=data$col_attrs$SampleID, total_feature=data$col_attrs[["_NGenes"]], total_counts=data$col_attrs[["_Total"]], coord_X=data$col_attrs[["_X"]], coord_Y=data$col_attrs[["_Y"]])

        ann_g <- data.frame(feature_symbol=data$row_attrs$Gene, is.feature=data$row_attrs[["_Selected"]], total_counts=data$row_attrs[["_Total"]])

        rownames(ann) <- colnames(data_matrix)
        rownames(ann_g) <- rownames(data_matrix)
        rm(data);

        sceset <- SingleCellExperiment(assays = list(counts = data_matrix), colData=ann, rowData=ann_g)

        thing <- strsplit(loom_file, "_")
        thing <- sub(".loom", "", thing[[1]][2])
        saveRDS(sceset, file=paste(thing,"SingCellExp_sparseM.rds", sep="_"))
}
