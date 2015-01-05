# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

$instances = (ENV['INSTANCES'] || 3).to_i

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  $instances.times do |n|
    id = n+1
    type = (id == 1) ? 'master' : 'client'
    client = (id % 2) == 0 ? 'appserver' : 'webserver'
    ip = "10.20.1.1#{id}"

    name = (type == 'master') ? "#{type}-#{id}" : "#{type}-#{client}-#{id}"

    config.vm.define name do |instance|
      instance.vm.hostname = name
      instance.vm.box = "ubuntu/trusty64"
      instance.vm.provision :shell, :path => 'scripts/puppet.sh'

      instance.vm.provision :puppet do |puppet|
        puppet.options        = '--hiera_config=/vagrant/hiera-no-consul.yaml'
        puppet.manifests_path = 'manifests'
        puppet.module_path    = [ 'modules', 'vendor/modules' ]
        puppet.manifest_file  = 'consul.pp'
      end

      instance.vm.provision :puppet do |puppet|
        puppet.options        = '--debug --verbose --summarize --reports store --hiera_config=/vagrant/hiera.yaml'
        puppet.manifests_path = 'manifests'
        puppet.module_path    = [ 'modules', 'vendor/modules' ]
        puppet.manifest_file  = 'base.pp'
      end
      instance.vm.network "private_network", :ip => ip
      instance.vm.provision :hosts
      # the Puppet Consul module doesn't register members
      # https://github.com/solarkennedy/puppet-consul/issues/31
      instance.vm.provision "shell", inline: "consul join master-1" unless type == 'master'
      instance.vm.provision :serverspec do |spec|
        spec.pattern = "./spec/#{type}/*_spec.rb"
      end if ENV['TESTING']

    end
  end


end
