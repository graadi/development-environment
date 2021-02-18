#!/bin/bash

# java
sudo yum install java-1.8.0-openjdk -y

# create a dedicated user for Apache Tomcat
sudo groupadd tomcat
sudo mkdir /opt/tomcat
sudo useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

# wownload and install Apache Tomcat.

sudo wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.0.46/bin/apache-tomcat-8.0.46.tar.gz
sudo tar -zxvf apache-tomcat-8.0.46.tar.gz -C /opt/tomcat --strip-components=1

# setup the permissions

chgrp -R tomcat /opt/tomcat/
chmod g+rwx /opt/tomcat/conf
chmod g+r /opt/tomcat/conf/*
chown -R tomcat /opt/tomcat/

# daemon service configuration file
sudo cp '/opt/vagrant/tomcat.service' '/etc/systemd/system/tomcat.service'

# modify permission
sudo chmod +x /etc/systemd/system/tomcat.service

# install haveged.
sudo yum install haveged -y
sudo systemctl enable haveged.service
sudo systemctl daemon-reload
sudo systemctl start haveged.service

# start and test Apache Tomcat

sudo systemctl enable tomcat.service
sudo systemctl daemon-reload
sudo systemctl start tomcat.service

# modify the firewall rules:

sudo firewall-cmd --zone=public --permanent --add-port=8080/tcp
sudo firewall-cmd --zone=public --permanent --add-port=8443/tcp
sudo service firewalld restart
