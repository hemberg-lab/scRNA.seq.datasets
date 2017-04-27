#!/bin/bash

# download data
wget -O klein.tar 'http://www.ncbi.nlm.nih.gov/geo/download/?acc=GSE65525&format=file'
mkdir klein
tar xvC klein -f klein.tar
bzip2 -d klein/*
