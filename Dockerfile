FROM ubuntu:latest

## Configure default locale, see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
	&& locale-gen en_US.utf8 \
	&& /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

## Use Debian unstable via pinning -- new style via APT::Default-Release
RUN echo "deb http://http.debian.net/debian sid main" > /etc/apt/sources.list.d/debian-unstable.list \
	&& echo 'APT::Default-Release "testing";' > /etc/apt/apt.conf.d/default

RUN  apt-get update && apt-get -y upgrade \
  && apt-get install -y \
    wget \
    r-base=${R_BASE_VERSION}* \
  && Rscript -e "if (!require('BiocInstaller')) {source('https://bioconductor.org/biocLite.R');biocLite('BiocInstaller')}" \
  && Rscript -e "if (!require('scater')) {source('https://bioconductor.org/biocLite.R');biocLite('scater')}"

ADD get_data.sh /
ADD R-scripts /R-scripts
CMD sh get_data.sh $name
