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
            unzip

# install scater: http://bioconductor.org/packages/scater/
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('BiocInstaller')"
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('scater')"

# install packages to generate Rmd reports
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('knitr')"

# add our scripts
ADD . /

# run scripts
CMD bash build.sh
