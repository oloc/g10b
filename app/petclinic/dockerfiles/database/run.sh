#!/bin/bash
# Workaround:
# https://ask.puppetlabs.com/question/10955/issues-with-ubuntu-docker-image-and-puppetlabs-mysql/
mv /sbin/initctl /sbin/oldinitctl
echo -e '#!/bin/bash\nif [ $1 == "--version" ]\nthen\n  echo "initctl (upstart 1.12.1)"\nfi\n/sbin/oldinitctl "$@"' > /sbin/initctl
chmod 755 /sbin/initctl

puppet apply /root/site.pp
# The container will run as long as the script is running,
# i.e. starting a long-living process:
exec tail -f /var/log/mysql/error.log