# Virtual machines for development purpose with Vagrant

The configuration has been tested using a Windows 10 host with Virtual Box and Hyper-V virtualization support. Virtualization must be enabled in case you get the following error, see the snapshot below:

<img src="https://raw.githubusercontent.com/graadi/development-environment/main/img/virtualization-error.png" />

### Prerequisites

Vagrant-vbguest is a Vagrant plugin which automatically installs the host's VirtualBox Guest Additions on the guest system.
To successfuly run the Vagrantfile and to mount ans sync the repository folders into Vagrant, the plugin must be installed first.

```
vagrant plugin install vagrant-vbguest
```
If the above plugin does not work, uninstall and fallback to an early version of it, as following:

```
vagrant plugin uninstall vagrant-vbguest
vagrant plugin install vagrant-vbguest --plugin-version 0.21
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
### List of machines (servers) that will be spun up by the Vagrantfile

|Vagrant managed machines|
|:-------------- |
|Docker|
|RabbitMQ|
|HAProxy|
|MySQL|
|Tomcat8|

For the tomcat server, there will be instructions to create and deploy a self signed certificate.
<img src="https://raw.githubusercontent.com/graadi/development-environment/main/img/vb.png" />
