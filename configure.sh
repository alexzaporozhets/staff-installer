#!/bin/bash
set -e

ECHO="echo -e"

colors=`tput colors`
if [ -n "$colors" -a "$colors" -ge 8 ]; then
  c_red=`tput setaf 1`
  c_green=`tput setaf 2`
  c_yellow=`tput setaf 3`
  c_norm=`tput sgr0`
  colors=1
fi

function fail()
{
  $ECHO ${c_red}FAIL: ${c_norm}$1
  GLOBALRET=1
}

function ok()
{
  $ECHO ${c_green}OK: ${c_norm}$1
}

function warn()
{
  $ECHO ${c_yellow}WARN: ${c_norm}$1
}

$ECHO
$ECHO = ${c_green} Generating passwords ${c_norm}

S3_ID=identity
S3_PASS=$(date +%s | sha256sum | base64 | head -c 32)
GRAFANA_PASS=$(date +%s | sha256sum | base64 | head -c 8)

IP=$(ifconfig | awk '/inet addr/{print substr($2,6)}'|grep -vE '^(127\.0\.0\.1|172\.[12])'|head -n 1)

$ECHO  = ${c_green} Creating bucket ${c_norm}
mkdir -p storage/s3/mystaff-files

$ECHO  = ${c_green} Generating config ${c_norm}

cat >.env <<EOT
AWS_ACCESS_KEY_ID=${S3_ID}
AWS_SECRET_ACCESS_KEY=${S3_PASS}
S3PROXY_IDENTITY=${S3_ID}
S3PROXY_CREDENTIAL=${S3_PASS}
GF_SECURITY_ADMIN_PASSWORD=${GRAFANA_PASS}
EOT

$ECHO = ${c_green} Reconfigure containers: ${c_norm}

docker-compose up -d 

$ECHO
$ECHO = ${c_green} Waiting for api starting up ${c_norm}
sleep 20

$ECHO
$ECHO = ${c_green} Testing: ${c_norm}
for f in app desktop api;do
  code=$(curl -sL -w "%{http_code}\\n"  --header "Host: $f.staff.local"  127.0.0.1 -o /dev/null)
  if [ $code -eq 200 ]; then
    $ECHO $f.staff.local ${c_green} $code ok ${c_norm}
  else
    $ECHO $f.staff.local ${c_red} $code fail ${c_norm}
  fi
done

$ECHO
$ECHO = ${c_green} Monitoring: ${c_norm}
$ECHO Grafana available as ${c_yellow} "http://${IP}:3003" ${c_norm}
$ECHO login: ${c_yellow} "admin" ${c_norm} password: ${c_yellow} "${GRAFANA_PASS}" ${c_norm}
$ECHO
$ECHO = ${c_green} Done! ${c_norm}
