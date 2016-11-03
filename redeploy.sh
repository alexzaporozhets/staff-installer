#!/bin/sh
. ~/.bash_profile
cd $(dirname $0)
aws ecr get-login|xargs sudo
docker-compose pull
docker-compose up -d
