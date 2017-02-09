#!/bin/bash

# download data
wget -O data.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE57249&format=file&file=GSE57249%5Ffpkm%2Etxt%2Egz'
gunzip data.txt.gz

# download extra data
wget 'https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/biase_cell_types.txt'
