# Install
Here are the scripts helping to install puppet master and puppet agent without the vagrant boxes. That can be helpfull if you want to pop your lab in a cloud. My advice is to create two instances, one with the Puppet agent, and one with the Puppet master, and to save them as template. At this point you should at the same situation than with vagrant.

## Usage
So, with this advice, I suggest to use in each instance (agent and master) that:

    env GIT_SSL_NO_VERIFY=true git clone https://github.com/oloc/g10b.git
    cd ./g10b/install
    . ./install.sh XXXX			# with XXXX=agent or master

## Useful use case
I decide to separate the installation and the configuration scripts with the goal to be abble to launch an update of the puppet-master configuration without to launch the whole process with the installation.

If you have already install the all things and if you want to push some updates in the puppet stuff, you just have to do:

    cd <root tree>/g10b
    . ./install/config-master.sh -u

This _-u option_ pulls lthe github repository and copies the puppet configuration files and manifests files. And, if you are not offline (see below), this _-u option_ install puppet modules regarding the retrieved **modules.lst** file.

## Useful option
You can toggle the **OffLine** parameter to 1 in the g10b/install/install.cfg if your are offline. This option can help if you want to launch without network and avoid the "apt-get" instructions and their friends. 
