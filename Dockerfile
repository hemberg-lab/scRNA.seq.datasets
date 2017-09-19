FROM rocker/r-base

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
RUN Rscript -e "source('https://bioconductor.org/biocLite.R');biocLite('BiocInstaller')" \
        && Rscript -e "install.packages('devtools')" \
        && Rscript -e "devtools::install_github('drisso/SingleCellExperiment')" \
        && Rscript -e "devtools::install_github('grimbough/Rhdf5lib')" \
        && Rscript -e "devtools::install_github('LTLA/beachmat')" \
        && Rscript -e "devtools::install_github('davismcc/scater')" \
        && Rscript -e "install.packages('rmarkdown')" \
        && Rscript -e "install.packages('knitr')"

# add our scripts
ADD . /

# run scripts
CMD bash build.sh
