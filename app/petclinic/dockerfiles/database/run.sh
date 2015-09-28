#!/bin/bash
puppet apply /root/site.pp
# The container will run as long as the script is running,
# i.e. starting a long-living process:
exec tail -f /var/log/mysql/error.log