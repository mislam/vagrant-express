VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

	config.vm.box = "precise64"
	config.vm.box_url = "http://files.vagrantup.com/precise64.box"

	config.vm.network "private_network", ip: "192.168.50.100"

	config.vm.provider :virtualbox do |vb|
		vb.customize ["modifyvm", :id, "--memory", "512"]
	end

	config.vm.provision :shell, :path => "system/provision.sh"

end