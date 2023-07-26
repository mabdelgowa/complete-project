#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-usermod
docker run -p 8080:80 docker.io/mahmoudabdelgowad/my-images:3.0
