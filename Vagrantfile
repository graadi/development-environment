# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"
  config.vm.provision "shell", path: "provision/scripts/node.sh", privileged: true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "vagrant-orchestration"
    
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
      vb.name = "docker-engine"
    end    
   end

   # rabbitmq node
   config.vm.define "rabbitmq" do |rabbitmq|
		rabbitmq.vm.hostname="rabbitmq-01.dev.internal"
		rabbitmq.vm.network "private_network", ip: "192.168.0.20"
    rabbitmq.vm.provision "shell", path: "provision/scripts/node-rabbitmq.sh", privileged: true
    rabbitmq.vm.provider :virtualbox do |vb|
      vb.name = "rabbitmq-queue-manager"
    end        
   end

   # tomcat8
   config.vm.define "tomcat8" do |tomcat8|
		tomcat8.vm.synced_folder "provision/files/tomcat8", "/opt/vagrant", nfs: true
		tomcat8.vm.hostname="tomcat8-01.dev.internal"
		tomcat8.vm.network "private_network", ip: "192.168.0.30"
    tomcat8.vm.provision "shell", path: "provision/scripts/node-tomcat8.sh", privileged: true
    tomcat8.vm.provider :virtualbox do |vb|
      vb.name = "tomcat8-01-web"
    end      
   end

   # additional tomcat server
   config.vm.define "tomcat8" do |api|
    api.vm.synced_folder "provision/files/tomcat8", "/opt/vagrant", nfs: true
    api.vm.synced_folder "provision/files/api", "/opt/vagrant/api", nfs: true
    api.vm.hostname="tomcat8-02.dev.internal"
    api.vm.network "private_network", ip: "192.168.0.31"
    api.vm.provision "shell", path: "provision/scripts/node-tomcat8.sh", privileged: true
    api.vm.provision "shell", path: "provision/scripts/node-api.sh", privileged: true
    api.vm.provider :virtualbox do |vb|
      vb.name = "tomcat8-02-api"
    end     
   end

   # mysql
   config.vm.define "mysql" do |mysql|
     mysql.vm.synced_folder "provision/files/databases", "/opt/vagrant/databases", nfs: true
     mysql.vm.hostname="mysql-01.dev.internal"
     mysql.vm.network "private_network", ip: "192.168.0.40"
     mysql.vm.network "forwarded_port", guest: 3306, host: 3360
     mysql.vm.provision "shell", path: "provision/sripts/node-mysql.sh", privileged: true
     mysql.vm.provider :virtualbox do |vb|
       vb.name = "mysql-database-server"
       vb.customize ["modifyvm", :id, "--memory", "1024"]
       vb.customize ["modifyvm", :id, "--cpus", "1"]
     end
   end

   # loadbalancer node
   config.vm.define "haproxy" do |haproxy|
    haproxy.vm.hostname="lb-01.dev.internal"
    haproxy.vm.network "private_network", ip: "192.168.0.50"
    haproxy.vm.provision "shell", path: "provision/scripts/node-haproxy.sh", privileged: true
    haproxy.vm.provider :virtualbox do |vb|
      vb.name = "haproxy-lb"
    end    
   end

end
