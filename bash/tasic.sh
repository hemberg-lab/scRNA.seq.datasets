#!/bin/bash

# data dowloaded from http://casestudies.brain-map.org/celltax on 22-02-17
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/genes_rpkm.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/genes_counts.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/ercc_counts.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/cell_metadata.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/cell_classification.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/tasic/cluster_metadata.csv

## looks like raw data containing more cells (probably outliers)
# wget -O clusts.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FClustering%5FResults%2Ecsv%2Egz'
# wget -O ercc_rpkm.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FERCC%5Fand%5FtdTomato%5FRPKM%2Ecsv%2Egz'
# wget -O ercc_counts.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FERCC%5Fand%5FtdTomato%5Fcounts%2Ecsv%2Egz'
# wget -O rpkm.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FRefSeq%5FRPKM%2Ecsv%2Egz'
# wget -O TPM.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FRefSeq%5FTPM%2Ecsv%2Egz'
# wget -O counts.csv.gz 'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE71585&format=file&file=GSE71585%5FRefSeq%5Fcounts%2Ecsv%2Egz'
# 
# gunzip clusts.csv.gz
# gunzip ercc_rpkm.csv.gz
# gunzip ercc_counts.csv.gz
# gunzip rpkm.csv.gz
# gunzip TPM.csv.gz
# gunzip counts.csv.gz
