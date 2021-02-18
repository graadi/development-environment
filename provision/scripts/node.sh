#!/bin/bash

# install
echo 'System update'
sudo yum update -y

echo 'Install net-tools and wget'
sudo yum install wget net-tools mlocate -y

echo 'Import GPG key'
sudo wget https://raw.githubusercontent.com/graadi/development-environment/main/provision/files/epel/RPM-GPG-KEY-EPEL-7
sudo mv RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo rpm -qa gpg*

echo 'Install epel-release'
sudo yum install epel-release -y

# Start firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld