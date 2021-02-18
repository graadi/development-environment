### Prerequisites

Vagrant-vbguest is a Vagrant plugin which automatically installs the host's VirtualBox Guest Additions on the guest system.
To successfuly run the Vagrantfile, the plugin must be installed first.

```
vagrant plugin install vagrant-vbguest
```

To update your plugins after a Vagrant upgrade, you can execute the following command.
```
vagrant plugin update vagrant-vbguest
```

If an update doesn’t resolve the problem or something has corrupted your current installation, you can repair the plugin.
```
vagrant plugin repair vagrant-vbguest
```

### Useful commands

* Start a vagrant machine:
```
vagrant up box-name
```
* Stop a vagrant machine:   
```
vagrant halt box-name
```
* Remove a vagrant machine:
```
vagrant destroy box-name
```
* Connect to a vagrant machine using ssh:
```
vagrant ssh box-name
```
### List of servers that will be created by the Vagrantfile

|VM's|
|:-------------- |
|Docker|
|RabbitMQ|
|Tomcat-8|
|Tomcat-8 with a selft-signed certificate|
|MySQL|
|HAProxy (Load balancer) - both tomcats will be accessible through it|
