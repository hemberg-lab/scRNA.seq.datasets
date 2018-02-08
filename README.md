# Public scRNA-Seq Datasets

This repository is used to build [scater](http://bioconductor.org/packages/scater/) objects and reports (in continuous integration manner) for various publicly available scRNA-Seq datasets used by our group. This pipeline is implemented using docker containers and cloud computing. The resulting website is available [here](https://hemberg-lab.github.io/scRNA.seq.datasets/). Below are some notes on the pipeline setup.

## Website

The website is generated using [MkDocs](http://www.mkdocs.org/) generator. Links to S3 storage and data annotations are added manually. If you are creating a pull request and adding new data please add its annotations to one of the files in the `website` folder.

## S3 storage

To list files on the S3 storage please use this [link](https://scrnaseq-public-datasets.s3.amazonaws.com/index.html).

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

1. Launch Ubuntu Trusty instance (`j1.large` flavour)
2. Add the instance to the `default`, `cloudforms_icmp_in`, `cloudforms_ssh_in` `cloudforms_web_in` security groups.
3. Create additional security group: `TCP` with port 8080 (this is needed for Jenkins) and add your instance to this group.
4. Associate a floating IP (FLOATING_IP) number with your instance.
5. Login to instance:
```
ssh -i ~/.ssh/your_key.pem ubuntu@FLOATING_IP
```
6. In the instance [install Jenkins](https://jenkins.io/doc/book/installing/#debian-ubuntu).

To setup Jenkins after installation go to http://FLOATING_IP:8080

7. In the instance [install docker](https://docs.docker.com/engine/installation/linux/ubuntu/). 

8. Resolve docker network issues (Sanger OpenStack problem only):
```{bash}
sudo bash -c "echo '{ \"bip\": \"10.10.0.1/16\", \"mtu\": 1400 }' > /etc/docker/daemon.json"
```

9. Add permission for Jenkins to run Docker:
```
sudo usermod -aG docker jenkins
```

Hard reboot your instance after that. Now Jenkins can run docker images.

10. Install `s3cmd` utility to be able to upload data to the S3 storage:
```
sudo apt-get install s3cmd
```

11. In Jenkins Export S3 key ID, secret key and region as environmental variables. Use secret text option provided by Jenkins. Some details available [here](http://serverfault.com/questions/724730/unable-to-use-aws-cli-in-jenkins-due-to-unable-to-locate-credentials-error).

## Jenkins build

```
# build and deploy
sh deploy.sh $WORKSPACE
```

## AWS Calculator

To calculate how much you can spend on AWS one can us the [AWS Calculator](https://calculator.s3.amazonaws.com/index.html).
