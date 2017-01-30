FROM rocker/r-base

# this tools are required for biomaRt package, which is required by scater
RUN apt-get update \ 
	&& apt-get install -y --no-install-recommends \
        aptitude \
        libcurl4-openssl-dev \
        libxml2-dev

RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('BiocInstaller')"
RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('scater')"

ADD get_data.sh /
ADD R-scripts /R-scripts
CMD sh get_data.sh $name
