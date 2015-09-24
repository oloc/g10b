FROM oloc/petclinic:base
MAINTAINER oloc
# Update Ubuntu
RUN apt-get update && apt-get -y upgrade

RUN puppet module install puppetlabs-mysql