#!/bin/bash

echo "Install updates"
sudo apt-get update
sudo apt-get upgrade

echo "Installing mongo"
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv EA312927
echo "deb http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update
sudo apt-get install -y mongodb-org
sudo mv /tmp/mongodb.service /etc/systemd/system/mongodb.service
sudo systemctl unmask mongodb
sudo systemctl start mongodb

echo "Installing node"
sudo apt-get install build-essential libssl-dev -y
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
nvm install node
nvm use node

echo "Installing mosca"
npm install mosca bunyan -g
echo "alias start-mosca=\"mosca --disable-stats --http-port 1884 > /dev/null 2>&1 &\"" >> ~/.bash_profile
echo "alias stop-mosca=\"kill $(pgrep -f mosca)\"" >> ~/.bash_profile
source ~/.bash_profile
start-mosca

echo "Installing rvm and Ruby"
gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
\curl -sSL https://get.rvm.io | bash -s stable --ruby=2.3.4
source /home/ubuntu/.rvm/scripts/rvm

echo "Installing nutella"
gem install nutella_framework --no-ri --no-rdoc
nutella checkup

