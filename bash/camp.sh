#!/bin/bash

# scRNASeq
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/suppl/GSE81252_data.cast.log2.lineage.csv.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/suppl/GSE81252_data.cast.log2.liverbud.csv.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE81nnn/GSE81252/matrix/GSE81252_series_matrix.txt.gz

gunzip GSE81252_data.cast.log2.lineage.csv.gz
gunzip GSE81252_data.cast.log2.liverbud.csv.gz
gunzip GSE81252_series_matrix.txt.gz
perl ../utils/parse_series_matrix.pl GSE81252_series_matrix.txt > GSE81252_Ann.txt

# bulk
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE40nnn/GSE40823/suppl/GSE40823_SpagnoliFM_RNASeq.FPKM.txt.gz
