  listen 80;
  listen 443 ssl;
  ssl_certificate /nginx/conf/ssl/staff.local.crt;
  ssl_certificate_key /nginx/conf/ssl/staff.local.key;
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
  ssl_prefer_server_ciphers on;
  ssl_session_cache shared:SSL:10m;
  ssl_dhparam /nginx/conf/ssl/dhparam.pem;

