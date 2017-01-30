FROM ubuntu:latest

RUN  apt-get update \
  && apt-get install -y wget

ADD get_data.sh /
CMD sh get_data.sh 
