# run the pipeline
docker run hemberglab/public-scrnaseq-datasets:latest

# copy files from docker container to local disk
assign() {
  eval "$1=\$(cat; echo .); $1=\${$1%.}"
}
assign container_id < <(docker ps -a | grep hemberglab/public-scrnaseq-datasets:latest | awk '{print $1;}')
docker cp `echo $container_id`:scater-objects $WORKSPACE/

s3cmd put scater-objects s3://scater-objects

# Delete all containers
# docker rm $(docker ps -a -q)
# Delete all images
# docker rmi $(docker images -q)
