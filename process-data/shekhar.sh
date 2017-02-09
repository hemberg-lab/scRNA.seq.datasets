#!/bin/bash

# dowload data
wget -O bipolar_data_Cell2016.Rdata.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE81904&format=file&file=GSE81904%5Fbipolar%5Fdata%5FCell2016%2ERdata%2Egz' 
# unzip data
gunzip bipolar_data_Cell2016.Rdata.gz
# download additional data
wget https://portals.broadinstitute.org/single_cell/data/retinal-bipolar-neuron-drop-seq/clust_retinal_bipolar.txt
