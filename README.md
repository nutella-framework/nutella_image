# Nutella images

*Problem*: nutella has a lot of dependencies and can be cumbersome to setup.

*Solution*: Let's use [Packer](https://packer.io) to create a series of images that can be used to launch an AWS instace with nutella already installed, run nutella locally with Vagrant and much more!


## How run nutella in AWS using this image
1. Head to your AWS console and then to EC2.
2. Click on "Launch Instance"
3. Select the latest version of the nutella AMI `ami-c732bbd1`, choose the size of the box and click on "Review and launch"
4. Click on "Launch", choose (or create) a key to SSH into the box, and click on "Launch instance".
5. Go back to EC2 > Security groups and select the one associated to your instance (likely sometihng along the lines of `launch-wizard-1`).
6. In the inbound tab add the following "Custom TCP rules"
```
TCP 1883 0.0.0.0/0
TCP 1884 0.0.0.0/0
TCP 27017 0.0.0.0/0
TCP 57880 0.0.0.0/0
TCP 57882 0.0.0.0/0
```
7. Head to EC2 > your instance and copy the public IPv4
8. SSH into the server via `ssh -i /path/to/key.pem ubuntu@<BOX_IP_ADDRESS>`
9. **CHECK EVERYTHING IS RUNNING**
10. **SET BROKER VIA `nutella broker set <BOX_IP_ADDRESS>`**
11. **Test with nutella new, nutella start**


## Want to contribute? Keep reading...
This repository contains:
- A _machine image_ for [Packer](https://packer.io) (`packer.json`) that describes an Ubuntu 16.04 box with nutella and all of its dependecies correctly configured. The image comes in several flavors such as ...
- A `Vagrantfile` used to test the provisioning script

Once you make some changes to the machine image you might want to build it with `packer build`. Before you do that and depending on the builder, you might need to provide some variables (e.g. your AWS ID and secret). You can do so using the `variables.json` file and then building with `packer build --only=amazon-ebs -var-file=variables.json packer.json`. Please see the Packer documentation for more details.
