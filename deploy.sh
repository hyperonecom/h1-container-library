#!/bin/sh
set -eux;
echo "$DOCKER_PASSWORD" | docker login "$DOCKER_REGISTRY" -u "$DOCKER_USERNAME" --password-stdin;
NODE=$(which node)
sudo $NODE ./generate.js "$FAMILY" -d