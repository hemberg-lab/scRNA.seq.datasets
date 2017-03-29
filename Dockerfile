FROM rocker/r-base

# openssl and libxml2 are required for biomaRt package, which is required by scater
# see this issue: https://github.com/sagemath/cloud/issues/114
# pandoc is required for generation of html scater reports
# gawk, tar, sed and unzip tools are required for processing the data files
RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
        aptitude \
        libcurl4-openssl-dev \
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
