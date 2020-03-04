#!/bin/sh

if [ -f "/data/etc/nginx/nginx.conf" ]; then
    nginx -g 'daemon off;' -c "/data/etc/nginx/nginx.conf";
else
    nginx -g 'daemon off;';
fi;