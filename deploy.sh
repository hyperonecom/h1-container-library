#!/bin/sh
set -eux;
echo "$DOCKER_PASSWORD" | docker login "$DOCKER_REGISTRY" -u "$DOCKER_USERNAME" --password-stdin;
sudo node ./generate.js "$FAMILY" -d
