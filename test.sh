#!/bin/sh
set -eux
IMAGE="h1cr.io/website/alpine-shell:latest" bats alpine-shell/test/*
IMAGE="h1cr.io/website/debian-shell:latest" bats debian-shell/test/*
IMAGE="h1cr.io/website/nginx-static:latest" bats nginx-static/test/*