#!/bin/sh
# Sync all code to /home/ubuntu/dev

rsync -avz --delete-excluded ../ ubuntu@54.221.206.123:~/dev/
