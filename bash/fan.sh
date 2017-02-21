#!/bin/bash

# download data
wget -O data.tar \
'http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE53386&format=file'
mkdir data
tar -C data -xvf data.tar
gunzip data/*

cd data
touch small.txt
touch large.txt
for f in `ls *{oocyte,zygote,2-cell,4-cell,8-cell,blastocyst,morula,TE,ICM}*`
do
    # number of columns in the file
    cols=$(awk '{print NF}' $f | sort -nu | tail -n 1)
    if (( $cols == 13 ))
    then
        # get FPKMs
        awk '{print $10}' $f > tmp1.txt
        sed -i "1s/.*/$f/" tmp1.txt
        paste large.txt tmp1.txt > tmp.txt
        mv tmp.txt large.txt
        # get gene names
        awk '{print $5}' $f > genes_large.txt
    else
        # get FPKMs
        awk '{print $3}' $f > tmp2.txt
        sed -i "1s/.*/$f/" tmp2.txt
        paste small.txt tmp2.txt > tmp.txt
        mv tmp.txt small.txt
        # get gene names
        awk '{print $2}' $f > genes_small.txt
    fi
done

cut -f 2- large.txt > large1.txt
cut -f 2- small.txt > small1.txt
paste genes_large.txt large1.txt > large_final.txt
paste genes_small.txt small1.txt > small_final.txt

mv large_final.txt ../large_final.txt
mv small_final.txt ../small_final.txt

cd ..
