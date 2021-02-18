#!/bin/bash

# Install test version of docker engine, also shell completions
echo 'Installing docker engine.'
curl -fsSL https://get.docker.com/ | sh

# Add the vagrant user to the docker group
sudo groupadd docker
sudo usermod -aG docker vagrant

# Configure the docker engine
# Daemon options: https://docs.docker.com/engine/reference/commandline/dockerd/
# Set both unix socket and tcp to make it easy to connect both locally and remote
# You can add TLS for added security (docker-machine does this automatically)
cat > /etc/docker/daemon.json <<END
{
    "hosts": [
        "unix://",
        "tcp://0.0.0.0:2375"
    ],
    "experimental": false,
    "debug": true,
    "metrics-addr": "0.0.0.0:9323"
}
END

# Docker compose
sudo yum install -y python-pip
pip install --upgrade pip
sudo pip install docker-compose

sudo systemctl start docker
sudo systemctl status docker
sudo systemctl enable docker
