#!/bin/bash
sudo yum update -y
sudo yum install -y docker
sudo systemctl start docker
sudo usermod -aG docker ec2-usermod
sudo curl -SL https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo curl https://raw.githubusercontent.com/mabdelgowa/demo-/main/Dockercompose.yaml -o Dockercompose.yaml
sudo docker-compose -f Dockercompose.yaml up
