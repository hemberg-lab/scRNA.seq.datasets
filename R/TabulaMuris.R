# R3.3
ann <- read.table("droplet_annotation.csv.gz", sep=",", header=TRUE)
ann[,1] <- paste(ann[,1], "-1", sep="")
meta <- read.table("droplet_metadata.csv.gz", sep=",", header=TRUE)

tissues <- levels(meta$tissue)

for ( t in tissues ) {
files <- Sys.glob(paste("droplet/",t,"*/", sep=""))
sparsemats <- list()
cellmats <- list()
for( f in files ) {
        require("scater")
        require("SingleCellExperiment")
        require("Matrix")

        cellbarcodes <- read.table(paste(f,"barcodes.tsv", sep=""))
        genenames <- read.table(paste(f,"genes.tsv", sep=""))
        molecules <- Matrix::readMM(paste(f,"matrix.mtx", sep=""))

        tmp <-  strsplit(f, "[-/]")[[1]]

        rownames(molecules) <- genenames[,1]
        colnames(molecules) <- paste(tmp[3], cellbarcodes[,1], sep="_")

        mouse <- meta[meta$channel == tmp[3],2]
        tissue <- meta[meta$channel == tmp[3],3]
        subtissue <- meta[meta$channel == tmp[3],4]
        sex <- meta[meta$channel == tmp[3],5]

        ann_subset <- ann[match(colnames(molecules), ann[,1]),]
        celltype <- ann_subset[,3]

        cell_anns <- data.frame(mouse = rep(mouse, times=ncol(molecules)), cell_type1=celltype, tissue=rep(tissue, times=ncol(molecules)), subtissue = rep(subtissue, times=ncol(molecules)), sex=rep(sex, times=ncol(molecules)))
        rownames(cell_anns) <- colnames(molecules);

        sparsemats[[f]] <- molecules
        cellmats[[f]] <- cell_anns

}

all_molecules <- do.call("cbind", sparsemats)
names(cellmats) <- rep(NULL, times=length(cellmats))
all_anns <- do.call("rbind", cellmats)
if (!identical(rownames(all_anns), colnames(all_molecules))) {print("Something is wrong")}
gene_data <- data.frame(feature_symbol=rownames(all_molecules));
sceset <- SingleCellExperiment(assays = list(counts = all_molecules), colData=all_anns, rowData=gene_data)
saveRDS(sceset, file=paste(t,"10X.rds", sep="_"))

}
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
