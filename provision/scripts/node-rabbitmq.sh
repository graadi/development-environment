#!/bin/bash

# install erlang
wget https://bintray.com/rabbitmq-erlang/rpm/download_file?file_path=erlang%2F23%2Fel%2F7%2Fx86_64%2Ferlang-23.2.4-1.el7.x86_64.rpm -O erlang-23.2.4-1.el7.x86_64.rpm

sudo rpm -Uvh erlang-23.2.4-1.el7.x86_64.rpm
sudo yum install erlang -y

erl

# install rabbitmq
wget https://bintray.com/rabbitmq/rpm/download_file?file_path=rabbitmq-server%2Fv3.8.x%2Fel%2F7%2Fnoarch%2Frabbitmq-server-3.8.12-1.el7.noarch.rpm -O rabbitmq.rpm

sudo rpm -Uvh rabbitmq.rpm
sudo yum install rabbitmq-server -y

# modify firewall rules
sudo firewall-cmd --zone=public --permanent --add-port=4369/tcp --add-port=25672/tcp --add-port=5671-5672/tcp --add-port=15672/tcp  --add-port=61613-61614/tcp --add-port=1883/tcp --add-port=8883/tcp
sudo firewall-cmd --reload

# add the service configuration for startup
sudo systemctl start rabbitmq-server.service
sudo systemctl enable rabbitmq-server.service

# enable and use the RabbitMQ management console
sudo rabbitmq-plugins enable rabbitmq_management
sudo chown -R rabbitmq:rabbitmq /var/lib/rabbitmq/

sudo rabbitmqctl add_user mqadmin UT67Uw856EyerMo3uZxh
sudo rabbitmqctl set_user_tags mqadmin administrator
sudo rabbitmqctl set_permissions -p / mqadmin ".*" ".*" ".*"

# enable rabbitmq ui
sudo rabbitmq-plugins enable rabbitmq_management
sudo systemctl restart rabbitmq-server
