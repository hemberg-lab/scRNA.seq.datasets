#!/bin/bash

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE87nnn/GSE87544/suppl/GSE87544_Merged_17samples_14437cells_count.txt.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE87nnn/GSE87544/suppl/GSE87544_1443737Cells.SVM.cluster.identity.renamed.csv.gz

gunzip GSE87544_Merged_17samples_14437cells_count.txt.gz
gunzip GSE87544_1443737Cells.SVM.cluster.identity.renamed.csv.gz
