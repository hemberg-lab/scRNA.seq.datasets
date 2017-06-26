#!/bin/bash

wget -O data.txt.gz \
'https://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE76983&format=file&file=GSE76983%5Fexpdata%5FBMJhscC%2Ecsv%2Egz'

gunzip data.txt.gz
