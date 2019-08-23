
Vagrant.configure("2") do |config|

  config.vm.provider "virtualbox" do |vb|
    vb.memory = "4096"
    vb.cpus = "2"
  end

  config.vm.provision "shell", inline: "echo Hello"
  config.vm.provision "file", source: "setup-tfe.sh", destination: "/tmp/setup-tfe.sh"
  config.vm.provision "file", source: "replicated.rli", destination: "/tmp/replicated.rli"
  config.vm.provision "shell", inline: "sudo chmod +x /tmp/setup-tfe.sh"
  config.vm.provision "shell", inline: "sudo /tmp/setup-tfe.sh"

  config.vm.define "ptfeprimary" do |ptfeprimary|
    ptfeprimary.vm.box = "ubuntu/bionic64"
    ptfeprimary.disksize.size = '50GB'

    ptfeprimary.vm.network "private_network", ip: "192.168.50.4"

  end

  config.vm.define "ptfesecondary" do |ptfesecondary|
    ptfesecondary.vm.box = "ubuntu/bionic64"
    ptfesecondary.disksize.size = '50GB'

    ptfesecondary.vm.network "private_network", ip: "192.168.50.5"

  end

end