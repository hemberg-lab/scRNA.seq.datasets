This docker is used for creation of the scater objects from the public datasets used by our lab.

Jenkins commands:

```
# run the pipeline
docker pull hemberglab/public-scrnaseq-datasets:latest
docker run hemberglab/public-scrnaseq-datasets:latest

# copy files from the last run docker container to local disk
alias dl='docker ps -l -q'
docker cp `dl`:scater-objects $WORKSPACE/

s3cmd put scater-objects s3://scater-objects

# Delete all containers
# docker rm $(docker ps -a -q)
# Delete all images
# docker rmi $(docker images -q)
```

To create an instance on a Sanger Cloud to be able to automatically run this docker, please follow these instructions:

1. Launch Ubuntu Trusty instance (`m1.medium` flavour)

2. Add the instance to the `default`, `cloudforms_icmp_in`, `cloudforms_ssh_in` `cloudforms_web_in` security groups.

3. Create additional security group: `TCP` with port 8080 (this is needed for Jenkins) and add your instance to this group

4. Associate a floating IP (FLOATING_IP) number with your instance.

5. In the instance install openjdk-7-jdk:
```
sudo apt-get update
sudo apt-get install openjdk-7-jdk
```

6. In the instance install Jenkins: https://wiki.jenkins-ci.org/display/JENKINS/Installing+Jenkins+on+Ubuntu

To setup Jenkins after installation go to http://FLOATING_IP:8080 (this is only accessible in the Sanger network, or from outside using VPN)

7. In the instance install docker: https://docs.docker.com/engine/installation/linux/ubuntu/

8. Add permission for Jenkins to run Docker:
```
sudo usermod -aG docker jenkins
```

Hard reboot your instance after that. Now Jenkins can run docker images.

9. Install `s3cmd` utility to be able to upload scater object to the S3 storage:
```
sudo apt-get install s3cmd
```

10. Add `.sc3cfg` configuration file to your instance with the access and secret keys.

Now you can upload files to the S3 storage using, e.g.:
```
s3cmd put textfile.txt s3://MYBUCKET
```

To make access to the S3 objects public use this command:
```
s3cmd setacl --acl-public s3://MYBUCKET/textfile.txt
```

Now the textfile.txt should be accessible at https://MYBUCKET.cog.sanger.ac.uk/textfile.txt
