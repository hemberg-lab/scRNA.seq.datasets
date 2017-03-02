#!/bin/bash

wget -O data.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE63472&format=file&file=GSE63472%5FP14Retina%5Fmerged%5Fdigital%5Fexpression%2Etxt%2Egz'
gunzip data.txt.gz

# download proper gene names
# downloaded from Ensembl Biomart on 1-3-17
wget https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/macosko/mart_export.txt

# download cluster labels
# downloaded from mccarroll lab website on 21-2-17:
# http://mccarrolllab.com/wp-content/uploads/2015/05/retina_clusteridentities.txt
wget https://scrnaseq-public-datasets.s3.amazonaws.com/manual-data/macosko/retina_clusteridentities.txt
