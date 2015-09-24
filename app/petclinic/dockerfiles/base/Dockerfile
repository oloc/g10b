FROM ubuntu:14.04
MAINTAINER oloc
# Update Ubuntu
RUN apt-get update && apt-get -y upgrade
# Install curl and wget
RUN apt-get -y install curl wget
# Install puppet stuff
RUN apt-get -y install puppet librarian-puppet
RUN puppet module install puppetlabs-stdlib