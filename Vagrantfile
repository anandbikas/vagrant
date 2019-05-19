# -*- mode: ruby -*-
# vi: set ft=ruby :
require "yaml"
require "fileutils"

# Load vagrantconfig.yml file
CONFIG = YAML.load(File.open("./vagrantconfig.yaml", File::RDONLY).read)

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.box = "bento/centos-6.9"
  config.vm.box_version = "201806.08.0"
  config.vm.box_check_update = false
  config.vm.boot_timeout = 0

  config.vm.box_url = "https://app.vagrantup.com/bento/boxes/centos-6.9"
  config.ssh.forward_agent = true

  # use default insecure key
  config.ssh.insert_key = false

  ############## my_vagrant VM #############
  #----------------------------------------#
  config.vm.define "my_vagrant", primary: true, autostart:true do |my_vagrant|

    my_vagrant.vm.provider :virtualbox do |vb|
      vb.name = "my_vagrant"
      vb.gui = false
      vb.customize ["modifyvm", :id, "--ioapic", "on"]
      vb.customize ["modifyvm", :id, "--cpus"  , "#{CONFIG['CPU']}"]
      vb.customize ["modifyvm", :id, "--memory", "#{CONFIG['MEMORY']}"]
    end

    network_config_my_vagrant(my_vagrant)

    my_vagrant.vm.hostname = "my-vagrant"
    my_vagrant.vm.network "private_network", ip: "#{CONFIG['PRIVATE_IP']}"

    config.vm.synced_folder "~/vagrant-shared", "/vagrant-shared", create: true

    my_vagrant.vm.provision "shell", path: "scripts/add_swap_file.sh"
    config.vm.provision :shell, :inline => "touch ~/vm_created"

  end
end

# my_vagrant network configuration #
#----------------------------------#
def network_config_my_vagrant(config)

  config.vm.network "forwarded_port", guest: 8080, host: 8080
  config.vm.network "forwarded_port", guest: 8000, host: 8000

end
