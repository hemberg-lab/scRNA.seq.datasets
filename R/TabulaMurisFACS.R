require("tibble")
require("scater")
require("SingleCellExperiment")

files <- Sys.glob("FACS/*-counts.csv.gz")
ann <- read.table("FACS_annotations.csv.gz", sep=",", header=TRUE)
meta <- read.table("FACS_metadata.csv.gz", sep=",", header=TRUE)
rownames(meta) <- meta[,1]

for( f in files ) {
        dat = read.delim(f, sep=",", header=TRUE)
        rownames(dat) <- dat[,1]
        dat <- dat[,-1]
        cellIDs <- colnames(dat)
        cell_info <- strsplit(cellIDs, "\\.")
        Well <- lapply(cell_info, function(x){x[1]})
        Well <- unlist(Well)
        Plate <- unlist(lapply(cell_info, function(x){x[2]}))
        Mouse <- unlist(lapply(cell_info, function(x){x[3]}))
        this_ann <- ann[match(cellIDs, ann[,1]),]
        celltype <- this_ann[,3]
        this_meta <- meta[Plate,]
        name <- this_meta[1,3]
        cell_anns <- data.frame(mouse = Mouse, well=Well, cell_type1=celltype, tissue=this_meta[,3], subtissue=this_meta[,4], FACS=this_meta[,5], sex=this_meta[,6])
        rownames(cell_anns) <- colnames(dat)
        gene_anns<- data.frame(feature_symbol=rownames(dat))
        sceset <- SingleCellExperiment(assays = list(counts = as.matrix(dat)), colData=cell_anns, rowData=gene_anns)
        saveRDS(sceset, file=paste(as.character(name), "FACS.rds", sep="_"))
}
