FROM rocker/r-devel

RUN apt-get update \
        && apt-get install -y --no-install-recommends \
            libcurl4-gnutls-dev \
            libssl-dev \
            libxml2-dev \
            pandoc \
            gawk \
            tar \
            sed \
            unzip \
            bzip2

# install R packages
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('BiocInstaller')" \
        && Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('scater')" \
        && Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('SingleCellExperiment')" \
        && Rscript -e "install.packages('rmarkdown')" \
        && Rscript -e "install.packages('knitr')"

# add our scripts
ADD . /

# run scripts
CMD bash build.sh
