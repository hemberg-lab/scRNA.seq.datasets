FROM rocker/r-base

# this tools are required for biomaRt package, which is required by scater
# see this issue: https://github.com/sagemath/cloud/issues/114
RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
        aptitude \
        libcurl4-openssl-dev \
        libxml2-dev \
        gawk

# install scater: http://bioconductor.org/packages/scater/
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('BiocInstaller')"
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('scater')"

# add our scripts
ADD get_data.sh /
ADD R-scripts /R-scripts

# run scripts
CMD sh get_data.sh $name
