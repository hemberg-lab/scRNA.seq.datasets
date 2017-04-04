#!/bin/bash

# download data
wget -O data.csv.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE81861&format=file&file=GSE81861%5FCell%5FLine%5FCOUNT%2Ecsv%2Egz'
gunzip data.csv.gz
