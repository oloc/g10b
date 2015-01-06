# Get your lab!
Many companies want a lab, a kind of research workspace. And so do some people. That's a good way to understand, learn, and improve some tools, let me say devops or infra-as-code tools. And in order to setup a such lab, they install the pool of tools.

At this point, I think to myself "They install!?" Ouch! We are speaking of an approch of automation and scripting way to configure and deploy, aren't we?  So I decide to code my own lab. The goal of this project is to launch an installer and wait and see for the result. The side effect is that I can install it again and again, I can test improvements easily without fearing a crash. And in fact if I crash my lab I just have to reinstall my master branch. 

As a starter, I prefer to setup the VM by myself, but the next step will be to pop them with vagrant, and the step after to configure Razor. Ambitious ? I'm not sure, that's the real world.

Anyway, currently the project V0.1 installs a puppet-master on a system (VM, standalone, whatever of your choice).


## Prerequisites
To use this tools, you need a hosting plateform for your puppet server:
* Operating System: Debian/Ubuntu 
* Packages: git, sudo, wget
* Accounts: a sudoer account or the root account

## Installation
On your System which will be your Puppet Server, follow the step by step commands below:

    env GIT_SSL_NO_VERIFY=true git clone https://github.com/oloc/g10b.git
    sudo ./g10b/install

By default, the account is **puppet** and that will be the owner of the installation. In another way, 


## My own configuration
I do not possess a datacenter or a cloud, so I proceed with VMs. To help you if you are in troubles, here is my own configuration:

* Operating System: Ubuntu 14.04.1 LTS, Trusty Tahr
* Kernel: 3.13.0-39-generic
* MoBo: W54_55SU1,SUW
* CPU: Intel(R) Core(TM) i7-4712MQ CPU @ 2.30GHz
* Memory: 2x 8GiB SODIMM DDR3 Synchrone 1600 MHz (0,6 ns)
* VirtualBox 4.3.10 r93012
