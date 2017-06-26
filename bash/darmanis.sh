#!/bin/bash

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE67nnn/GSE67835/matrix/GSE67835-GPL15520_series_matrix.txt.gz
wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE67nnn/GSE67835/matrix/GSE67835-GPL18573_series_matrix.txt.gz

gunzip GSE67835-GPL15520_series_matrix.txt.gz
gunzip GSE67835-GPL18573_series_matrix.txt.gz

perl ../utils/parse_series_matrix.pl GSE67835-GPL15520_series_matrix.txt > Ann_part1.txt
mv ExprMat.txt ExprMat1.txt
perl ../utils/parse_series_matrix.pl GSE67835-GPL18573_series_matrix.txt > Ann_part2.txt
mv ExprMat.txt ExprMat2.txt
