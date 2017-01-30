FROM ubuntu:latest

RUN  apt-get update && apt-get -y upgrade \
  && apt-get install -y \
    wget \
    r-base \
  && Rscript -e "if (!require('BiocInstaller')) {source('https://bioconductor.org/biocLite.R');biocLite('BiocInstaller')}" \
  && Rscript -e "if (!require('devtools')) install.packages('devtools')" \
  && Rscript -e "if (!require('scater')) devtools::install_github("davismcc/scater", build_vignettes = TRUE)"

ADD get_data.sh /
ADD R-scripts /R-scripts
CMD sh get_data.sh $name
