#!/bin/bash -e

echo "Installing nutella"
source /home/ubuntu/.rvm/scripts/rvm
gem install nutella_framework -v 0.7.2 --no-ri --no-rdoc
nutella checkup

echo "Your image is ready!"
