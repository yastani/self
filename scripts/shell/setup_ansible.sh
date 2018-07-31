sudo sed -i -e 's/^releasever=latest$/releasever=2017.03/g' /etc/yum.conf
sudo yum update -y
sudo pip install ansible
