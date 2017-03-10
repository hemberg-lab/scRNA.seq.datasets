FROM hemberglab/scrna.seq.datasets-docker

# add our scripts
ADD . /

# run scripts
CMD bash build.sh
