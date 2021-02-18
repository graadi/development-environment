#!/bin/bash

# install

echo 'System update'
sudo yum update -y

echo 'Install net-tools and wget'
sudo yum install wget net-tools mlocate -y

sudo wget https://raw.githubusercontent.com/graadi/development-environment/main/provision/files/epel/RPM-GPG-KEY-EPEL-7
#echo 'sudo mv /opt/vagrant/RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7'
sudo mv RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

echo 'Import GPG key'
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo rpm -qa gpg*

#sudo wget https://github.com/graadi/development-environment/blob/main/provision/files/epel/epel-release-latest-7.noarch.rpm
#echo 'sudo rpm -ivh /opt/vagrant/epel-release-latest-7.noarch.rpm'
#sudo rpm -ivh epel-release-latest-7.noarch.rpm

echo 'Install epel-release'
sudo yum install epel-release -y

# firewall on
sudo systemctl start firewalld
sudo systemctl enable firewalld