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
  config.vm.define "docker" do |docker|

    docker.vm.hostname="docker-01.dev.internal"
    docker.vm.network "private_network", ip: "192.168.0.10"
    docker.vm.provision "shell", path: "provision/scripts/node-docker.sh", privileged: true
    
    docker.vm.provider :virtualbox do |vb|
      vb.name = "docker"
    end    
  end

  # rabbitmq node
  config.vm.define "rabbitmq" do |rabbitmq|
    
    rabbitmq.vm.hostname="rabbitmq-01.dev.internal"
    rabbitmq.vm.network "private_network", ip: "192.168.0.20"
    rabbitmq.vm.provision "shell", path: "provision/scripts/node-rabbitmq.sh", privileged: true
    rabbitmq.vm.provider :virtualbox do |vb|
      vb.name = "rabbitmq"
    end        
  end  
end
