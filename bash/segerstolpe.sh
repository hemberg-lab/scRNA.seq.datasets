#!/bin/bash

# get data
wget https://www.ebi.ac.uk/arrayexpress/files/E-MTAB-5061/E-MTAB-5061.processed.1.zip
unzip E-MTAB-5061.processed.1.zip
head -n 1 pancreas_refseq_rpkms_counts_3514sc.txt > labels.txt
sed -i '1s/#samples//' labels.txt

# get metadata
wget https://www.ebi.ac.uk/arrayexpress/files/E-MTAB-5061/E-MTAB-5061.sdrf.txt
