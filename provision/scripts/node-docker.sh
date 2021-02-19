#!/bin/bash

# install prerequisites
sudo apt-get update
sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y

# add docker’s official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

# install the docker engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y

# install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.28.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/sbin/docker-compose
sudo chmod +x /usr/local/sbin/docker-compose
docker-compose --version

# start the docker engine
sudo systemctl status docker
sudo systemctl is-enabled docker.service

# verify installation
sudo docker run hello-world
