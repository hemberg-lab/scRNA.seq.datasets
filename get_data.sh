#!/bin/bash

# check arguments
if [ $# -eq 0 ]; then
    echo "Please provide a name of the dataset!"
    exit 1
fi

# patel dataset
if [ $name = "patel" ]; then
    wget -O data.txt.gz \
    'http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE57872&format=file&file=GSE57872%5FGBM%5Fdata%5Fmatrix%2Etxt%2Egz'
    gunzip data.txt.gz
fi

Rscript R-scripts/$name.R
