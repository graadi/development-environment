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

### Useful Vagrant commands

* Start a box:
```
vagrant up box-name
```
* Stop a box:   
```
vagrant halt box-name
```
* Remove a box:
```
vagrant destroy box-name
```
* Connect to a box (ssh):
```
vagrant ssh box-name
```
### Servers list

|VM's|
|:-------------- |
|Docker|
|RabbitMQ|
|Tomcat-8|
|Tomcat-8|
|MySQL|
|HAProxy|
