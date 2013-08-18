#!/bin/sh
# Use this script when starting a brand new server
# Run as root

# These packages are needed to run puppet
# TODO: copy to /etc/puppet
sudo apt-get install puppet facter

puppet server
puppet agent --server=localhost --test
