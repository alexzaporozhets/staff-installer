 tar -zcf azure.tar.gz docker-compose.yml etc/ src install.sh; ~/.aws/staff.sh aws s3 cp azure.tar.gz s3://staff-azure/
