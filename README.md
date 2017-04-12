# Nutella images

*Problem*: nutella has a lot of dependencies and can be cumbersome to setup.

*Solution*: Let's use [Packer](https://packer.io) to create a series of images that can be used to launch an AWS instace with nutella already installed, run nutella locally with Vagrant and much more!


## How run nutella in AWS using this image
1. Head to your AWS console and then to EC2.
1. Click on the "Launch Instance" button.
1. On the left panel, select the latest version of the nutella AMI `nutella_framework/images/nutella-v0.7.2 (ami-5bde554d)` from the "Community AMIs". 
1. Choose the size of the box (`t2.micro` works for simple deployments) and click on "Review and launch".
1. Click on "Launch" on the next screen, choose (or create) a key to SSH into the box, and click on "Launch instance".
1. Go back to EC2, select "Security groups" from the left panel, and select the one associated to your instance (likely something along the lines of `launch-wizard-1`).
1. In the "Inbound" tab add the following "Custom TCP rules": `TCP 1883 0.0.0.0/0`, `TCP 1884 0.0.0.0/0`, `TCP 57880 0.0.0.0/0`, `TCP 57882 0.0.0.0/0`
1. Head to EC2 and the public IPv4 of your instance.
1. SSH into the server by running this command on your laptop terminal `ssh -i /path/to/key.pem ubuntu@<BOX_IP_ADDRESS>`
1. Once you are on the box, the first thing you need to do is to set the nutella broker to the IP address of this instace. You can do that by running `nutella broker set <BOX_IP_ADDRESS>`.
1. Finally, make sure that mongo is runnig by running `sudo systemctl start mongodb`.
1. **Congratulations!** You are now ready to test if nutella is running! Pull your favorite app and run it! :shipit:


## Want to contribute? Keep reading...
This repository contains:
- A _machine image_ for [Packer](https://packer.io) (`packer.json`) that describes an Ubuntu 16.04 box with nutella and all of its dependecies correctly configured. The image comes in several flavors such as ...
- A `Vagrantfile` used to test the provisioning script

Once you make some changes to the machine image you might want to build it with `packer build`. Before you do that and depending on the builder, you might need to provide some variables (e.g. your AWS ID and secret). You can do so using the `variables.json` file and then building with `packer build --only=amazon-ebs -var-file=variables.json packer.json`. Please see the Packer documentation for more details.
