FROM oloc/petclinic:base
MAINTAINER oloc

RUN puppet module install puppetlabs-apache

ADD site.pp /root/site.pp
RUN chmod +x /root/site.pp
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh

EXPOSE 80

CMD ["/root/run.sh"]