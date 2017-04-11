#!/bin/bash

echo "Installing mongo"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo mv /tmp/mongodb.service /etc/systemd/system/mongodb.service
sudo systemctl unmask mongodb
sudo systemctl start mongodb

echo "Installing docker"
sudo apt-get install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce
sudo gpasswd -a ubuntu docker
sudo service docker restart
newgrp docker

echo "Installing rvm and Ruby"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.4.1
source /home/ubuntu/.rvm/scripts/rvm

echo "Installing nutella"
gem install nutella_framework -v 0.7.1 --no-ri --no-rdoc
nutella checkup

echo "Install updates"
sudo apt-get update
sudo apt-get upgrade -y
sudo unattended-upgrades
sudo reboot

echo "Done building image"
