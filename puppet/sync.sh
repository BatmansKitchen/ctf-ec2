#!/bin/sh

# Run as root

rsync -avz --delete-excluded ./ /etc/puppet
chown -R root:root /etc/puppet
