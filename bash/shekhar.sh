#!/bin/bash

# dowload data
wget -O bipolar_data_Cell2016.Rdata.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE81904&format=file&file=GSE81904%5Fbipolar%5Fdata%5FCell2016%2ERdata%2Egz' 
# unzip data
gunzip bipolar_data_Cell2016.Rdata.gz
# download additional data
# downloaded from single cell portal on 2-2-17:
# https://portals.broadinstitute.org/single_cell/data/retinal-bipolar-neuron-drop-seq/clust_retinal_bipolar.txt
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/clust_retinal_bipolar.txt
