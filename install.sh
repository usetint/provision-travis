#!/bin/sh

set -e

export DEBIAN_FRONTEND=noninteractive

. recipes/sunzi.sh
. recipes/sources.sh

# Update apt catalog and upgrade installed packages
sunzi.mute "apt-get update"
sunzi.mute "apt-get -y upgrade"

for PACKAGE in git ntp curl; do
	sunzi.install "$PACKAGE" || true
done

. recipes/docker.sh
. recipes/travis-worker.sh
. recipes/docker-image.sh

echo "You should reboot the machine now."
