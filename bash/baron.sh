#!/bin/bash

# download data
wget -O data.tar \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE84133&format=file'
tar -xvf data.tar
gunzip *.gz
