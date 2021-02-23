# -*- mode: ruby -*-
# vi: set ft=ruby :

# parameters list
dockerip="192.168.0.10"
rabbitmqip="192.168.0.20"
haproxyip="192.168.0.30"
mysqlip="192.168.0.40"
tomcatip="192.168.0.50"

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
    docker.vm.network "private_network", ip: "#{dockerip}"
    docker.vm.provision "shell", path: "provision/scripts/node-docker.sh", privileged: true
    
    docker.vm.provider :virtualbox do |vb|
      vb.name = "docker"
    end    
  end

  # rabbitmq node
  config.vm.define "rabbitmq" do |rabbitmq|
    
    rabbitmq.vm.hostname="rabbitmq-01.dev.internal"
    rabbitmq.vm.network "private_network", ip: "#{rabbitmqip}"
    rabbitmq.vm.provision "shell", path: "provision/scripts/node-rabbitmq.sh", privileged: true
    rabbitmq.vm.provider :virtualbox do |vb|
      vb.name = "rabbitmq"
    end        
  end
  
  # loadbalancer node
  config.vm.define "haproxy" do |haproxy|

    haproxy.vm.hostname="lb-01.dev.internal"
    haproxy.vm.network "private_network", ip: "#{haproxyip}"
    haproxy.vm.provision "shell", path: "provision/scripts/node-haproxy.sh", privileged: true
    haproxy.vm.provider :virtualbox do |vb|
      vb.name = "haproxy"
    end    
  end
  
  # mysql database
  config.vm.define "mysql" do |mysql|

    mysql.vm.synced_folder "provision/files/databases", "/opt/vagrant/databases", type: "virtualbox"
    mysql.vm.hostname="mysql-01.dev.internal"
    mysql.vm.network "private_network", ip: "#{mysqlip}"
    mysql.vm.network "forwarded_port", guest: 3306, host: 3360
    mysql.vm.provision "shell", path: "provision/scripts/node-mysql.sh", privileged: true
    mysql.vm.provider :virtualbox do |vb|
      vb.name = "mysql"
      vb.customize ["modifyvm", :id, "--memory", "1024"]
      vb.customize ["modifyvm", :id, "--cpus", "1"]
    end
  end
  
  # tomcat8
  config.vm.define "tomcat8" do |tomcat8|
    
    tomcat8.vm.synced_folder "provision/files/tomcat8", "/opt/vagrant", type: "virtualbox"
    tomcat8.vm.synced_folder "provision/files/api", "/opt/vagrant/api", type: "virtualbox"
    tomcat8.vm.hostname="tomcat.dev.internal"
    tomcat8.vm.network "private_network", ip: "#{tomcatip}"
    tomcat8.vm.provision "shell", path: "provision/scripts/node-tomcat8.sh", privileged: true
    tomcat8.vm.provision "shell", path: "provision/scripts/node-api.sh", privileged: true
    tomcat8.vm.provider :virtualbox do |vb|
      vb.name = "tomcat8"
    end      
  end   
end
