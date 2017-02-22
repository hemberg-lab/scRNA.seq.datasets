#!/bin/bash

mkdir scater-objects

# process files and create scater objects
for f in `ls bash`; do
    name=(${f//./ })
    echo "processing $name..."
    mkdir $name
    cd $name
    # download and process a dataset; create scater object
    sh ../bash/$name.sh
    Rscript ../R/$name.R
    cp *.rds ../scater-objects
    cd ..
    rm -rf $name
done

# generate a report for each scater object
mkdir scater-reports
for f in `ls scater-objects`; do
    name=(${f//./ })
    echo "making report for $name..."
    f1="'$f'"
    name1="'$name'"
    Rscript -e "rmarkdown::render('report.Rmd', params = list(file = $f1, set_title = $name1))"
    mv report.html $name.html
    mv $name.html scater-reports/
done
