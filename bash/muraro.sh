#!/bin/bash

wget -O data.csv.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE85241&format=file&file=GSE85241%5Fcellsystems%5Fdataset%5F4donors%5Fupdated%2Ecsv%2Egz'
gunzip data.csv.gz
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/muraro/cell_type_annotation_Cels2016.csv
