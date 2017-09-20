#!/bin/bash

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE93nnn/GSE93374/suppl/GSE93374_Merged_all_020816_DGE.txt.gz
gunzip GSE93374_Merged_all_020816_DGE.txt.gz

wget ftp://ftp.ncbi.nlm.nih.gov/geo/series/GSE93nnn/GSE93374/suppl/GSE93374_cell_metadata.txt.gz
gunzip GSE93374_cell_metadata.txt.gz
