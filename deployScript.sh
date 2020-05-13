#!/bin/bash

while getopts ":s:" OPTION; do
    : "$OPTION" "$OPTARG"
    case $OPTION in
      s)  server=$OPTARG;
    esac
done

echo "Deploying to $server"

ssh root@$server <<EOF
cd /var/www
if [ -d "ccrgm-backend" ]; then
	cd ccrgm-backend
	git pull origin master
else
	git clone https://github.com/plengSPK/ccrgm-backend.git
    chmod 0777 /var/www/html/ccrgm-backend/app/web/assets
	cd ccrgm-backend
fi
cd app
composer update
EOF