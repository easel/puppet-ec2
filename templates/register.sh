#!/bin/bash

#you will need to have the key available in the instance in the same dir as
#this script
#DNS_KEY=Kuser.domain.com.+157+47950.private
DOMAIN=local

#USER_DATA=`/usr/bin/curl -s http://169.254.169.254/latest/user-data`
#HOSTNAME=`echo $USER_DATA`
HOSTNAME=`hostname`
#set also the hostname to the running instance
#hostname $HOSTNAME.$DOMAIN

PUBNAME=`/usr/bin/curl -s http://169.254.169.254/latest/meta-data/public-hostname`
cat<<EOF | /usr/bin/nsupdate -v
server aws-fw-00
zone $DOMAIN
update delete $HOSTNAME.$DOMAIN CNAME
update add $HOSTNAME.$DOMAIN 60 CNAME $PUBNAME.
send
EOF
