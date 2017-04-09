# Nutella images

*Problem*: nutella has a lot of dependencies and can be cumbersome to setup.

*Solution*: Let's use [Packer](https://packer.io) to create a series of images that can be used to launch an AWS instace with nutella already installed, run nutella locally with Vagrant and much more!

## How run nutella in AWS using this image
TODO

## Want to contribute? Keep reading...
This repository contains:
- A _machine image_ for [Packer](https://packer.io) (`packer.json`) that describes an Ubuntu 16.04 box with nutella and all of its dependecies correctly configured. The image comes in several flavors such as ...
- A `Vagrantfile` used to test the provisioning script

Once you make some changes to the machine image you might want to build it with `packer build`. Before you do that and depending on the builder, you might need to provide some variables (e.g. your AWS ID and secret). You can do so using the `variables.json` file and then building with `packer build --only=amazon-ebs -var-file=variables.json packer.json`. Please see the Packer documentation for more details.

## TODOs for v1
- [ ] Figure out why `nutella checkup` fails the first time and fix
- [ ] Figure out broker config for nutella (manual step after DNS?)