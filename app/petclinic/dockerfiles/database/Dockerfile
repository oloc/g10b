FROM oloc/petclinic:base
MAINTAINER oloc

RUN puppet module install puppetlabs-mysql

ADD site.pp /root/site.pp
RUN chmod +x /root/site.pp
ADD run.sh /root/run.sh
RUN chmod +x /root/run.sh
ADD initDB.sql /root/initDB.sql
RUN chmod +x /root/initDB.sql

EXPOSE 3306

CMD ["/root/run.sh"]