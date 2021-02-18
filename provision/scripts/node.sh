#!/bin/bash

# install
sudo yum -y install wget net-tools mlocate

sudo wget https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
sudo mv RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo rpm -qa gpg*

sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
sudo rpm -ivh epel-release-latest-7.noarch.rpm

sudo yum update -y

# firewall on
sudo systemctl enable firewalld
sudo systemctl start firewalld

