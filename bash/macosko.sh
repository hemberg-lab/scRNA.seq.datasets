#!/bin/bash

# download the data
wget -O data1.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626793&format=file&file=GSM1626793%5FP14Retina%5F1%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data2.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626794&format=file&file=GSM1626794%5FP14Retina%5F2%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data3.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626795&format=file&file=GSM1626795%5FP14Retina%5F3%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data4.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626796&format=file&file=GSM1626796%5FP14Retina%5F4%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data5.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626797&format=file&file=GSM1626797%5FP14Retina%5F5%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data6.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626798&format=file&file=GSM1626798%5FP14Retina%5F6%2Edigital%5Fexpression%2Etxt%2Egz'
wget -O data7.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSM1626799&format=file&file=GSM1626799%5FP14Retina%5F7%2Edigital%5Fexpression%2Etxt%2Egz'

gunzip data1.txt.gz
gunzip data2.txt.gz
gunzip data3.txt.gz
gunzip data4.txt.gz
gunzip data5.txt.gz
gunzip data6.txt.gz
gunzip data7.txt.gz

# download cluster labels
# downloaded from mccarroll lab website on 21-2-17:
# http://mccarrolllab.com/wp-content/uploads/2015/05/retina_clusteridentities.txt
wget https://scrnaseq-public-datasets.s3.amazonaws.com/manual-data/macosko/retina_clusteridentities.txt
