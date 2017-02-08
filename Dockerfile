FROM hemberglab/scrna.seq.datasets-docker

# add our scripts
ADD process-data /process-data
ADD create-scater /create-scater
ADD report.Rmd /
ADD build.sh /

# run scripts
CMD bash build.sh
