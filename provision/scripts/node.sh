#!/bin/bash

# initial system update and upgrade
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

# install wget, net-tools and mlocate, the last one is for searching
sudo apt-get install wget net-tools mlocate -y

# install and configure the ufw tool (firewall)
sudo ufw status verbose
sudo ufw enable