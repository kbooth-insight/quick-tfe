
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
  end


  # config.vm.provision "shell", path: "setup-docker.sh"
  config.vm.provision "file", source: "replicated.rli", destination: "/tmp/replicated.rli"
  config.vm.provision "shell", path: "setup-tfe.sh"


  config.vm.define "ptfeprimary" do |config|
    config.vm.box = "ubuntu/bionic64"
    config.disksize.size = '50GB'
    config.vm.network "private_network", ip: "192.168.50.4"
  end

  # config.vm.define "ptfesecondary" do |config|
  #   config.vm.box = "ubuntu/bionic64"
  #   config.disksize.size = '50GB'
  #   config.vm.network "private_network", ip: "192.168.50.5"
  # end
end