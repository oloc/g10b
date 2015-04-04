# Install
Here are the scripts helping to install puppet master and puppet agent without the vagrant boxes. They were the bootstraps in the vagrant files. I have extracted them from the version V0.3, I have cleaned them a little bit, and I put them here. But I didn't test them.

## Usage
So, with this caution, I suggest to use it like that:

    env GIT_SSL_NO_VERIFY=true git clone https://github.com/oloc/g10b.git
    cd ./g10b/install
    . ./install.sh XXXX			# with XXXX=agent or master

## Useful use case
I decide to split install-master.sh into install-master.sh and config-master.sh with the goal to be abble to launch an update of the puppet-master configuration without to have to launch the whole process from the provision.

If you have already install the all things, push some updates in the puppet stuff, you just have to do:

    cd <root tree>/g10b/install
    . ./config-master.sh -u

## Useful option
You can toggle the **Offline** parameter to 1 in the g10b/install/install.cfg if your are offline. This option can help if you want to launch without network and avoid the "apt-get" instructions and their friends. 