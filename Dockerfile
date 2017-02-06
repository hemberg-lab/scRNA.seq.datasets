FROM hemberglab/scater-docker

# these tools are required for processing the data files
RUN apt-get update \ 
	&& apt-get install \
        gawk \
        tar \
        sed

# add our scripts
ADD process-data /process-data
ADD create-scater /create-scater
ADD report.Rmd /
ADD build.sh /

# run scripts
CMD bash build.sh
