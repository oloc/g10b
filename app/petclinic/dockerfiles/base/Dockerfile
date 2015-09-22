FROM ubuntu:14.04
MAINTAINER oloc
# Update Ubuntu
RUN apt-get update && apt-get -y upgrade
# Install puppet stuff
RUN apt-get -y install puppet librarian-puppet
RUN puppet module install puppetlabs-stdlib