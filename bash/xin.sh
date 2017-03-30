#!/bin/bash

# download data
wget -O data.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE81608&format=file&file=GSE81608%5Fhuman%5Fislets%5Frpkm%2Etxt%2Egz'
gunzip data.txt.gz

wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/xin/human_gene_annotation.csv
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/xin/human_islet_cell_identity.txt
