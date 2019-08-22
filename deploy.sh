#!/bin/sh
set -eux
docker push h1cr.io/website/alpine-shell:latest
docker push h1cr.io/website/debian-shell:latest
docker push h1cr.io/website/nginx-static:latest