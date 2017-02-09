# Public scRNA-Seq Datasets

This repository is used to build [scater](http://bioconductor.org/packages/scater/) objects and reports (in continuous integration manner) for various publicly available scRNA-Seq datasets used by our group. This pipeline is implemented using docker containers and cloud computing. The resulting website is available [here](https://hemberg-lab.github.io/scRNA.seq.datasets/). Below are some notes on the pipeline setup.

## Website

The website is generated using [MkDocs](http://www.mkdocs.org/) generator. Links to S3 storage and data annotations are added manually. If you are creating a pull request and adding new data please add its annotations to one of the files in the `website` folder.

## Instance setup

### AWS

1. Launch Amazon Linux EC2 instance.
2. Using security groups add access to the instance on port 8080.
3. Connect to instance and [install Jenkins](http://sanketdangi.com/post/62715793234/install-configure-jenkins-on-amazon-linux).
4. Add permission for Jenkins to run Docker:
```
sudo usermod -aG docker jenkins
```

Hard reboot your instance after that. Now Jenkins can run docker images.

5. Install `s3cmd` utility to be able to upload data to the S3 storage:
```
sudo apt-get install s3cmd
```

6. In Jenkins Export S3 key ID, secret key and region as environmental variables. Use secret text option provided by Jenkins. Some details available [here](http://serverfault.com/questions/724730/unable-to-use-aws-cli-in-jenkins-due-to-unable-to-locate-credentials-error).

7. File listing can be setup on AWS S3 bucket using this [plugin](https://github.com/rufuspollock/s3-bucket-listing).


### OpenStack Cloud (Sanger)

1. Launch Ubuntu Trusty instance (`m1.medium` flavour)
2. Add the instance to the `default`, `cloudforms_icmp_in`, `cloudforms_ssh_in` `cloudforms_web_in` security groups.
3. Create additional security group: `TCP` with port 8080 (this is needed for Jenkins) and add your instance to this group.
4. Associate a floating IP (FLOATING_IP) number with your instance.
5. In the instance install openjdk-7-jdk:
```
sudo apt-get update
sudo apt-get install openjdk-7-jdk
```
6. In the instance [install Jenkins](https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu).

To setup Jenkins after installation go to http://FLOATING_IP:8080 (this is only accessible via Sanger wired network).

7. In the instance [install docker](https://docs.docker.com/engine/installation/linux/ubuntu/). 

8. Add permission for Jenkins to run Docker:
```
sudo usermod -aG docker jenkins
```

Hard reboot your instance after that. Now Jenkins can run docker images.

9. Install `s3cmd` utility to be able to upload data to the S3 storage:
```
sudo apt-get install s3cmd
```

10. In Jenkins Export S3 key ID, secret key and region as environmental variables. Use secret text option provided by Jenkins. Some details available [here](http://serverfault.com/questions/724730/unable-to-use-aws-cli-in-jenkins-due-to-unable-to-locate-credentials-error).

## Jenkins build

### AWS

```
# run the pipeline
docker pull hemberglab/scrna.seq.datasets:latest
docker run hemberglab/scrna.seq.datasets:latest

# copy files from the last run docker container to local disk
alias dl='docker ps -l -q'
docker cp `dl`:scater-objects $WORKSPACE/
docker cp `dl`:scater-reports $WORKSPACE/

# copy files to S3
aws s3 cp scater-objects s3://scrnaseq-public-datasets/scater-objects/ --recursive
aws s3 cp scater-reports s3://scrnaseq-public-datasets/scater-reports/ --recursive

# clean up
rm -r scater-objects
rm -r scater-reports
# cleanup after docker usage
docker rm $(docker ps -a -q)
docker rmi $(docker images -q)
```

### OpenStack Cloud (Sanger)

```
# run the pipeline
docker pull hemberglab/public-scrnaseq-datasets:latest
docker run hemberglab/public-scrnaseq-datasets:latest

# copy files from the last run docker container to local disk
alias dl='docker ps -l -q'
docker cp `dl`:scater-objects $WORKSPACE/
docker cp `dl`:scater-reports $WORKSPACE/

# copy files to S3


# clean up
rm -r scater-objects
rm -r scater-reports
# delete all containers
docker rm $(docker ps -a -q)
```

## AWS Calculator

To calculate how much you can spend on AWS one can us the [AWS Calculator](https://calculator.s3.amazonaws.com/index.html).
