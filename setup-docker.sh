sudo setenforce Permissive
sudo yum install -y yum-utils device-mapper-persistent-data lvm2
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum install -y docker-ce-18.09.2 docker-ce-cli-18.09.2 containerd.io-18.09.2
sudo systemctl start docker
