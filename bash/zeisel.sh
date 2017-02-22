#!/bin/bash

# download data
wget -O zeisel.txt \
'https://s3.amazonaws.com/scrnaseq-public-datasets/manual-data/zeisel/expression_mRNA_17-Aug-2014.txt'

# remove some headers
sed -i '1d' zeisel.txt
sed -i '2,10d' zeisel.txt

# assign labels
sed -i '1s/ #//' zeisel.txt
