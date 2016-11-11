#!/bin/sh
. ~/.bash_profile
cd $(dirname $0)
aws ecr get-login|xargs sudo
docker-compose pull
docker-compose up -d
docker rm $(docker ps -q) >/dev/null 2>&1
docker rmi $(docker images -f "dangling=true" -q)
