# -*- mode: ruby -*-
# vi: set ft=ruby :

require "vagrant"

if Vagrant::VERSION < "1.2.1"
  raise "The Omnibus Build Lab is only compatible with Vagrant 1.2.1+"
end

host_project_path = File.expand_path("..", __FILE__)
guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"
project_name = "occi-server"

Vagrant.configure("2") do |config|

  config.vm.hostname = "#{project_name}-omnibus-build-lab"

  config.vm.define 'ubuntu-12.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-ubuntu-12.04"
    c.vm.box_url = "http://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_chef-11.4.4.box"
  end

  config.vm.define 'ubuntu-13.04' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-ubuntu-13.04"
    c.vm.box_url = "http://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-13.04_provisionerless.box"
  end

  config.vm.define 'centos-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-centos-6.4"
    c.vm.box_url = "http://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-6.4_chef-11.4.4.box"
  end

  config.vm.define 'centos-5' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-centos-5.9"
    c.vm.box_url = "http://opscode-vm.s3.amazonaws.com/vagrant/opscode_centos-5.9_chef-11.4.4.box"
  end

  config.vm.define 'debian-6' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "opscode-debian-6.0.7"
    c.vm.box_url = "http://opscode-vm.s3.amazonaws.com/vagrant/opscode_debian-6.0.7_chef-11.2.0.box"
  end

  config.vm.define 'debian-7' do |c|
    c.berkshelf.berksfile_path = "./Berksfile"
    c.vm.box = "vb-fbr-debian-7.0"
    c.vm.box_url = "http://vagrantboxes.footballradar.com/wheezy64.box"
  end

  config.vm.provider :virtualbox do |vb|
    vb.customize [
      "modifyvm", :id,
      "--memory", "1536",
      "--cpus", "2"
    ]
  end

  config.omnibus.chef_version = :latest

  config.berkshelf.enabled = true
  config.berkshelf.berksfile_path = "./Berksfile"

  config.ssh.forward_agent = true

  host_project_path = File.expand_path("..", __FILE__)
  guest_project_path = "/home/vagrant/#{File.basename(host_project_path)}"

  config.vm.synced_folder host_project_path, guest_project_path

  config.vm.provision :chef_solo do |chef|
    chef.json = {
      "omnibus" => {
        "build_user" => "vagrant",
        "build_dir" => guest_project_path,
        "install_dir" => "/opt/#{project_name}"
      }
    }

    chef.run_list = [
      "recipe[omnibus::default]"
    ]
  end

  config.vm.provision :shell, :inline => <<-OMNIBUS_BUILD
    export PATH=/usr/local/bin:$PATH
    cd #{guest_project_path}
    su vagrant -c "bundle install --binstubs"
    su vagrant -c "bin/omnibus build project #{project_name}"
  OMNIBUS_BUILD
end
