# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "ubuntu/bionic64"
  config.vm.provision "shell", path: "provision/scripts/node.sh", privileged: true

  config.vm.provider "virtualbox" do |vb|
    
    # Display the VirtualBox GUI when booting the machine
    vb.gui = false
    
    # Customize the amount of memory on the VM:
    vb.memory = "512"
    vb.cpus = 1
  end

  # docker node
  #config.vm.define "docker" do |docker|

    #docker.vm.hostname="docker-01.dev.internal"
    #docker.vm.network "private_network", ip: "192.168.0.10"
    #docker.vm.provision "shell", path: "provision/scripts/node-docker.sh", privileged: true
    
    #docker.vm.provider :virtualbox do |vb|
      #vb.name = "docker"
    #end    
  #end

  # rabbitmq node
  #config.vm.define "rabbitmq" do |rabbitmq|
    
    #rabbitmq.vm.hostname="rabbitmq-01.dev.internal"
    #rabbitmq.vm.network "private_network", ip: "192.168.0.20"
    #rabbitmq.vm.provision "shell", path: "provision/scripts/node-rabbitmq.sh", privileged: true
    #rabbitmq.vm.provider :virtualbox do |vb|
      #vb.name = "rabbitmq"
    #end        
  #end
  
  # loadbalancer node
  #config.vm.define "haproxy" do |haproxy|

    #haproxy.vm.hostname="lb-01.dev.internal"
    #haproxy.vm.network "private_network", ip: "192.168.0.50"
    #haproxy.vm.provision "shell", path: "provision/scripts/node-haproxy.sh", privileged: true
    #haproxy.vm.provider :virtualbox do |vb|
      #vb.name = "haproxy"
    #end    
  #end
  
  # mysql database
    config.vm.define "mysql" do |mysql|
      
    mysql.vm.synced_folder "provision/files/databases", "/opt/vagrant/databases", type: "virtualbox"
    mysql.vm.hostname="mysql-01.dev.internal"
    mysql.vm.network "private_network", ip: "192.168.0.40"
    mysql.vm.network "forwarded_port", guest: 3306, host: 3360
    mysql.vm.provision "shell", path: "provision/scripts/node-mysql.sh", privileged: true
    mysql.vm.provider :virtualbox do |vb|
      vb.name = "mysql"
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end  
end
