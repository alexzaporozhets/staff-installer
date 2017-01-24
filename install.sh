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
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -d ' {\n \"name\": \"${STAFF_ADMIN_USERNAME|-admin}\",\n \"email\": \"${STAFF_ADMIN_EMAIL:-admin@staff.com}\",\n \"password\": \"${STAFF_ADMIN_PASSWORD|-changeme}\"\n}' localhost/api/1.0/register/super-admin
