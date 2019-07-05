#!/bin/sh
set -eux;
echo "$DOCKER_PASSWORD" | docker login "$DOCKER_REGISTRY" -u "$DOCKER_USERNAME" --password-stdin;
./deploy.sh;
