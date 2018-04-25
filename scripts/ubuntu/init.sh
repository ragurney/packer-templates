#!/bin/bash

set -e
set -x

sudo sed -i -e 's,^\(ACTIVE_CONSOLES="/dev/tty\).*,\11",' /etc/default/console-setup
for f in /etc/init/tty[^1]*.conf; do
  sudo mv "$f"{,.bak}
done

# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.
apt-get -y update
apt-get -y upgrade
apt-get -y install build-essential linux-headers-$(uname -r)
apt-get -y install vim curl

# Install NFS client
apt-get -y install nfs-common
