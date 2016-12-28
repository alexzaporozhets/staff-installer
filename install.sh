#!/bin/bash
set -e
env >env
device=/dev/sdc
mount=/media
if file -sL $device | grep -v 'XFS filesystem'; then
  echo "Formatting"
  mkfs -t xfs $device
fi
mkdir -p $mount
grep $device /proc/mounts || mount $device $mount
docker-compose -p staff up -d
