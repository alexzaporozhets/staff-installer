#!/bin/sh
aws ecr get-login|xargs sudo
docker login staffreg-justinstaff.azurecr.io -u staffreg -p /+/+=z=/DY7r1dZn/+=/P+E=Y/MYLrbo -e -
for f in staff-api-server staff-app-web staff-app-admin staff-app-desktop; do
docker pull 847166803921.dkr.ecr.us-east-1.amazonaws.com/$f
docker tag 847166803921.dkr.ecr.us-east-1.amazonaws.com/$f staffreg-justinstaff.azurecr.io/$f
docker push staffreg-justinstaff.azurecr.io/$f
done
