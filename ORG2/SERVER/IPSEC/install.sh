#!/bin/bash

apt-get install -y ipsec-tools

cp ipsec-tools.conf /etc/

sudo service setkey restart
