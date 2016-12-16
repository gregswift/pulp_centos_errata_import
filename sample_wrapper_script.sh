#!/bin/bash

cd /tmp

wget -N http://cefs.steve-meier.de/errata.latest.xml
wget -N https://www.redhat.com/security/data/oval/com.redhat.rhsa-all.xml

[ -z "$PASSWORD" ] && PASSWORD=$(grep -i ^default_password /etc/pulp/server.conf | awk '{print $2}')

# NOTE:
# The "Org-CentOS_7_x86_64-CentOS_7_x86_64_Base" repository name is just an example.
# To list your repositories:
#  pulp-admin -u admin -p $PASSWORD repo list
[ -z "$BASE_REPO" ] && BASE_REPO=Org-CentOS_7_x86_64-CentOS_7_x86_64_Base
[ -z "$UPDATES_REPO" ] && UPDATES_REPO=Org-CentOS_7_x86_64-CentOS_7_x86_64_Updates
[ -z "$EXTRAS_REPO" ] && EXTRAS_REPO=Org-CentOS_7_x86_64-CentOS_7_x86_64_Extras

/sbin/errata_import.pl --errata=/tmp/errata.latest.xml --rhsa-oval=/tmp/com.redhat.rhsa-all.xml --user=admin --password=$PASSWORD --debug --include-repo=$BASE_REPO --include-repo=$UPDATES_REPO --include-repo=$EXTRAS_REPO
