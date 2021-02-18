#!/bin/bash

# Install Erlang

wget http://packages.erlang-solutions.com/erlang-solutions-1.0-1.noarch.rpm
sudo rpm -Uvh erlang-solutions-1.0-1.noarch.rpm
sudo yum install erlang -y

# Install RabbitMQ
wget https://github.com/rabbitmq/rabbitmq-server/releases/download/rabbitmq_v3_6_11/rabbitmq-server-3.6.11-1.el7.noarch.rpm
sudo rpm --import https://www.rabbitmq.com/rabbitmq-signing-key-public.asc
sudo yum install rabbitmq-server-3.6.11-1.el7.noarch.rpm -y

# Modify firewall rules

sudo firewall-cmd --zone=public --permanent --add-port=4369/tcp --add-port=25672/tcp --add-port=5671-5672/tcp --add-port=15672/tcp --add-port=61613-61614/tcp --add-port=1883/tcp --add-port=8883/tcp
sudo firewall-cmd --reload
sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service

# Enable and use the RabbitMQ management console

sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

sudo rabbitmqctl add_user mqadmin UT67Uw856EyerMo3uZxh
sudo rabbitmqctl set_user_tags mqadmin administrator
sudo rabbitmqctl set_permissions -p / mqadmin ".*" ".*" ".*"
