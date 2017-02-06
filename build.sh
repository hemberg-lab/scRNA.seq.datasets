#!/bin/bash

mkdir scater-objects

# process files and create scater objects
for f in `ls process-data`; do
    name=(${f//./ })
    mkdir $name
    cd $name
    # download and process a dataset; create scater object
    sh ../process-data/$name.sh
    Rscript ../create-scater/$name.R
    cp *.rds ../scater-objects
    cd ..
    rm -rf $name
done

# generate a report for each scater object
mkdir scater-reports
for f in `ls scater-objects`; do
    name=(${f//./ })
    f1="'$f'"
    Rscript -e "rmarkdown::render('report.Rmd', params = list(file = $f1, set_title = $name))"
    mv report.html $name.html
    mv $name.html scater-reports/
done
