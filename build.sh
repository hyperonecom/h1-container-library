#!/bin/sh
set -eux
docker build -t h1cr.io/website/alpine-shell:latest alpine-shell/latest
docker build -t h1cr.io/website/debian-shell:latest debian-shell/latest
docker build -t h1cr.io/website/nginx-static:latest nginx-static/latest