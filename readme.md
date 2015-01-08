# Get your lab!
Many companies want a lab, a kind of research workspace. And so do some people. That's a good way to understand, learn, and improve some tools, let me say devops or infra-as-code tools. And in order to setup a such lab, they install the pool of tools.

At this point, I think to myself "They install!?" Ouch! We are speaking of an approch of automation and scripting way to configure and deploy, aren't we?  So I decide to code my own lab. The goal of this project is to launch an installer and wait and see for the result. The side effect is that I can install it again and again, I can test improvements easily without fearing a crash. And in fact if I crash my lab I just have to reinstall my master branch. 

As a starter, I prefer to setup the VM by myself, but the next step will be to pop them with vagrant, and the step after to configure Razor. Ambitious ? I'm not sure, that's the real world.

Anyway, currently the project V0.1 installs a puppet-master on a system (VM, standalone, whatever of your choice). It's more than a bootstrap. It's a bootstrap installing puppet-master and a feeder of modules and manifests needed to configure puppet itself by itself.


## Prerequisites
To use this tools, you need a hosting plateform with:
* git
* Vagrant 
* VirtualBox

## Installation
On your System which will be your Puppet Server, follow the step by step commands below:

    env GIT_SSL_NO_VERIFY=true git clone https://github.com/oloc/g10b.git
    cd ./g10b/vagrant
    sudo vagrant up

This commands will pop the needed VMs in virtualbox and install the stuff.
If you possess a datacenter or a cloud and if you want to test the installation you have to launch the *install* scripts in the appropriate machines.

## My own configuration
I do not possess a datacenter or a cloud, so I proceed with VMs. To help you if you are in troubles, here is my own configuration:

* Operating System: Ubuntu 14.04.1 LTS, Trusty Tahr
* Kernel: 3.13.0-39-generic
* MoBo: W54_55SU1,SUW
* CPU: Intel(R) Core(TM) i7-4712MQ CPU @ 2.30GHz
* Memory: 2x 8GiB SODIMM DDR3 Synchrone 1600 MHz (0,6 ns)
* VirtualBox 4.3.10 r93012
