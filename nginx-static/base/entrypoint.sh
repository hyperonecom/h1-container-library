#!/bin/sh

if [ -f "/data/etc/nginx/nginx.conf" ]; then
    exec nginx -g 'daemon off;' -c "/data/etc/nginx/nginx.conf";
else
    exec nginx -g 'daemon off;';
fi;
