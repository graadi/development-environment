#!/bin/bash

# install erlang
wget -O- https://packages.erlang-solutions.com/ubuntu/erlang_solutions.asc | sudo apt-key add -
echo "deb https://packages.erlang-solutions.com/ubuntu bionic contrib" | sudo tee /etc/apt/sources.list.d/erlang.list

sudo apt-get update
sudo apt-get install erlang -y

# add rabbitmq repository to ubuntu 18.04
wget -O- https://dl.bintray.com/rabbitmq/Keys/rabbitmq-release-signing-key.asc | sudo apt-key add -
wget -O- https://www.rabbitmq.com/rabbitmq-release-signing-key.asc | sudo apt-key add -
echo "deb https://dl.bintray.com/rabbitmq/debian $(lsb_release -sc) main" | sudo tee /etc/apt/sources.list.d/rabbitmq.list

# install rabbitmq
sudo apt-get update
sudo apt-get install rabbitmq-server -y

# post install verification
sudo systemctl status  rabbitmq-server.service
sudo rabbitmqctl status | grep RabbitMQ

systemctl is-enabled rabbitmq-server.service

# modify firewall rules
sudo ufw allow ssh
sudo ufw enable
sudo ufw allow 5672,15672,4369,25672/tcp
sudo ufw status

# enable and use the RabbitMQ management console
sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

sudo rabbitmqctl add_user mqadmin UT67Uw856EyerMo3uZxh
sudo rabbitmqctl set_user_tags mqadmin administrator
sudo rabbitmqctl set_permissions -p / mqadmin ".*" ".*" ".*"
sudo systemctl restart rabbitmq-server
