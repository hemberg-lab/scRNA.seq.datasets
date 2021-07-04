require("Matrix")
require("SingleCellExperiment")

gene_rule="intersect" # rule for homogenizing genes

ann <- read.delim("MCA_All-batch-removed-assignments.csv", header=T)
ann2 <- read.delim("MCA-cell-ann.csv", header=T, sep=",")
tissues <- lapply(strsplit(as.character(ann[,1]), "_"), function(x){x[1]})
tissues <- unique(unlist(tissues))
tissues <- tissues[tissues != "BoneMarrowcKit"]
tissues[tissues=="Male(fetal)Gonad"] <- "FetalMaleGonad"
tissues[tissues=="NeonatalBrain"] <- "NeontalBrain" #May need to change this if they have updated the download files 
for (t in tissues) {
        files1 <- Sys.glob(paste("MCA_DGE/",t,"*.txt.gz", sep=""))
        files2 <- Sys.glob(paste("MCA_rmbatch_dge_all/",t,"*.txt.gz",sep=""))

        if (length(files1) < 1) {next;}
        if (length(files1) != length(files2)) {files2 <- c()}
        sparsemats <- list()
        batchmats <- list()
        annmats <-list()
        for (f in 1:length(files1)) {
                dat <- read.delim(files1[f], sep=" ", header=T)
                if (length(files2) >= f) {
                        dat2 <- read.delim(files2[f], sep=" ", header=T)
                }
                local_ann2 <- ann2[match(colnames(dat), ann2[,1]),]
                local_ann2$Cell.name <- colnames(dat)
                local_ann2$file <- rep(files1[f], times=nrow(local_ann2))

                # Only keep those with annotation information
                local_ann2 <- local_ann2[!is.na(local_ann2[,2]),]

                M <- Matrix::Matrix(as.matrix(dat), sparse=T)
                M <- M[,colnames(M) %in% local_ann2$Cell.name]
                sparsemats[[f]] <- M

                if (length(files2) >= f) {
                        M <- Matrix::Matrix(as.matrix(dat2), sparse=T)
                        M <- M[,colnames(M) %in% local_ann2$Cell.name]
                        batchmats[[f]] <- M
                }
                annmats[[f]] <- local_ann2
        }
        names(annmats) <- rep(NULL, times=length(annmats))
        names(sparsemats) <- rep(NULL, times=length(sparsemats))
        names(batchmats) <- rep(NULL, times=length(batchmats))
        # Homogenize genes across files for same tissue
        genes <- c();
        for (i in c(sparsemats, batchmats)) {
                if (length(genes) == 0) {
                        genes <- rownames(i)
                } else {
                        if (gene_rule == "intersect") {
                                genes <- intersect(genes, rownames(i))
                        } else if (gene_rule == "union") {
                                genes <- union(genes, rownames(i))
                        } else {
                                warn("I don't know how to homogenize genes - assuming all have the same")
                                break;
                        }
                }
        }
        genes <- sort(genes);

        for(i in 1:length(sparsemats)) {
                matches <- match(genes, rownames(sparsemats[[i]]))
                sparsemats[[i]] <- rbind( sparsemats[[i]], rep(0, times=ncol(sparsemats[[i]])) )
                matches[is.na(matches)] <- nrow(sparsemats[[i]]);

                sparsemats[[i]] <- sparsemats[[i]][ matches, ]
                rownames(sparsemats[[i]]) <- genes
        }
        for(i in 1:length(batchmats)) {
                matches <- match(genes, rownames(batchmats[[i]]))
                batchmats[[i]] <- rbind( batchmats[[i]], rep(0, times=ncol(batchmats[[i]])) )
                matches[is.na(matches)] <- nrow(batchmats[[i]]);

                batchmats[[i]] <- batchmats[[i]][ matches, ]
                rownames(batchmats[[i]]) <- genes
        }

        all_molecules <- do.call("cbind", sparsemats)
        all_batchcor <- do.call("cbind", batchmats)
        all_anns <- do.call("rbind", annmats)
        if (!identical(rownames(all_anns), colnames(all_molecules))) {print("Something is wrong")}
        if (!identical(colnames(all_batchcor), colnames(all_molecules))) {
                matches <- match(colnames(all_molecules), colnames(all_batchcor))
                all_batchcor <- cbind(all_batchcor, rep(0, times=nrow(all_batchcor)))
                matches[is.na(matches)] <- ncol(all_batchcor)

                all_batchcor <- all_batchcor[,matches]
                colnames(all_batchcor) <- colnames(all_molecules)
        }

        rownames(all_anns) <- colnames(all_molecules)
        all_anns <- all_anns[,-1]
        all_anns$cell_type1 <- all_anns$Cell.Anno
        gene_ann <- data.frame(feature_symbol = rownames(all_molecules))

        sceset <- SingleCellExperiment(assays = list(counts = all_molecules), colData=all_anns, rowData=gene_ann)
        if (length(files1) == length(files2)) {
                assay(sceset, "batchcor") <- all_batchcor
        }

        print(paste(t, "Done!"))
        saveRDS(sceset, file=paste(t,"SingCellExp_sparseM.rds", sep="_"))
}
