#!/bin/bash

WORKSPACE=$1

# Delete every Docker containers
# Must be run first because images are attached to containers
docker rm -f $(docker ps -a -q)

# Delete every Docker image
docker rmi -f $(docker images -q)

# get the docker
docker pull quay.io/hemberg-group/scrna-seq-datasets:latest
# run the docker
docker run quay.io/hemberg-group/scrna-seq-datasets

# copy files from the last run docker container to local disk
alias dl='docker ps -l -q'
docker cp `dl`:scater-objects $WORKSPACE/
docker cp `dl`:scater-reports $WORKSPACE/

# copy results to S3
aws s3 cp scater-objects s3://scrnaseq-public-datasets/scater-objects/ --recursive
aws s3 cp scater-reports s3://scrnaseq-public-datasets/scater-reports/ --recursive
