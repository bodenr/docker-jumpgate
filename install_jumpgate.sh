#!/bin/bash

set -e

# apt-get install packages
apt-get update
apt-get install -y gcc git python-pip gunicorn python-dev

# clone and install jumpgate
cd /usr/local/ && git clone https://github.com/softlayer/jumpgate.git
cd /usr/local/jumpgate && pip install -r tools/requirements.txt
python setup.py install

# configure jumpgate
addgroup srv && useradd -r -g srv jumpgate
mkdir /etc/jumpgate && chown jumpgate:srv /etc/jumpgate
cp /usr/local/jumpgate/etc/* /etc/jumpgate && chown jumpgate:srv /etc/jumpgate/* && chmod 640 /etc/jumpgate/*
sed -i 's/localhost/0.0.0.0/g' /etc/jumpgate/identity.templates
sed -i 's/5000/12710/g' /etc/jumpgate/identity.templates
sed -i 's/127.0.0.1/0.0.0.0/g' /etc/jumpgate/jumpgate.conf
KEY=`date +%s | sha256sum | base64 | head -c 16 ; echo`
ADMIN_TOKEN=`< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;`
sed -i "s/ADMIN/${ADMIN_TOKEN}/g" /etc/jumpgate/jumpgate.conf
sed -i "s/SET ME TO SOMETHING/${KEY}/g" /etc/jumpgate/jumpgate.conf

