FROM ubuntu:latest

RUN  apt-get update \
  && apt-get install -y \
    wget \
    r-base \
  && Rscript -e "if (!require('scater')) {source('https://bioconductor.org/biocLite.R');biocLite('scater')}"

ADD get_data.sh /
CMD sh get_data.sh $name
