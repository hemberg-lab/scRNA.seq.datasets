FROM ubuntu:latest

ENV R_BASE_VERSION 3.3.2

RUN  apt-get update && apt-get -y upgrade \
  && apt-get install -y \
    wget \
    r-base=${R_BASE_VERSION}* \
  && Rscript -e "if (!require('BiocInstaller')) {source('https://bioconductor.org/biocLite.R');biocLite('BiocInstaller')}" \
  && Rscript -e "if (!require('scater')) {source('https://bioconductor.org/biocLite.R');biocLite('scater')}"

ADD get_data.sh /
ADD R-scripts /R-scripts
CMD sh get_data.sh $name
