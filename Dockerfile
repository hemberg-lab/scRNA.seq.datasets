FROM hemberglab/scrna.seq.datasets-docker

# add our scripts
ADD bash /bash
ADD R /R
ADD report.Rmd /
ADD build.sh /

# run scripts
CMD bash build.sh
