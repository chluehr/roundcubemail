
Vagrant::Config.run do |config|

    config.vm.box = "precise64"
    config.vm.box_url = "http://files.vagrantup.com/precise64.box"

    # enable VirtualBox GUI mode (headless is defaut)
    config.vm.boot_mode = :gui

    # Guest Port 80 -> Host Port 8080 (Access Apache)
    config.vm.forward_port 80, 8080

    # mount project htdocs directory to /var/www instead of /vagrant
    config.vm.share_folder "v-root", "/var/www", "."

    # run setup.sh to configure the machine
    config.vm.provision :shell, :path => "Vagrant-setup.sh"

    # Workaround for some Kernels / Ubuntu 12.10 hosts
    config.vm.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
 
end

