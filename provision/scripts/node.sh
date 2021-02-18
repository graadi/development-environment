#!/bin/bash

# install
echo 'sudo yum -y install wget net-tools mlocate'
sudo yum -y install wget net-tools mlocate

sudo wget https://dl.fedoraproject.org/pub/epel/RPM-GPG-KEY-EPEL-7
#echo 'sudo mv /opt/vagrant/RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7'
sudo mv RPM-GPG-KEY-EPEL-7 /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7

echo 'sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7'
sudo rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7
sudo rpm -qa gpg*

sudo wget https://github.com/graadi/development-environment/blob/main/provision/files/epel/epel-release-latest-7.noarch.rpm
#echo 'sudo rpm -ivh /opt/vagrant/epel-release-latest-7.noarch.rpm'
sudo rpm -ivh epel-release-latest-7.noarch.rpm

echo 'sudo yum -y update'
sudo yum -y update

# firewall on
sudo systemctl enable firewalld
sudo systemctl start firewalld

