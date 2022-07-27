# -*- mode: ruby -*-
# vi: set ft=ruby :
#require 'dotenv'
#Dotenv.load
Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/jammy64"
  config.vm.provider "virtualbox" do |vb|
    vb.memory = ENV['VB_MEMORY']
    vb.cpus = ENV['VB_CPUS']
    vb.gui = false #ENV['VB_GUI']
    vb.name = ENV['GH_RUNNER_NAME']
  end
  config.vm.network "forwarded_port", guest: 8082, host: 9082, id: "PrivateRegistry"
  config.vm.network "forwarded_port", guest: 9000, host: 9083, id: "Sonarqube"
  
  config.vm.provision "create-runner", privileged:false, type: "shell", 
  args: [ENV['GH_RUNNER_URL'], ENV['GH_RUNNER_TOKEN'], ENV['GH_RUNNER_NAME'], 
        ENV['GH_RUNNER_LABELS'], ENV['GH_VERSION'], ENV['SHA256']], 
  path: "create-runner.sh"

  config.vm.provision "install_dependencies", type: "shell", path: "install-dependencies.sh"
  config.vm.provision "docker_compose_up", type: "shell", inline: "docker-compose -f /vagrant/docker-compose.yaml up -d"
  config.vm.provision "configure_max_map", type: "shell", path: "configure-vm-max-map.sh"
end