#!/bin/bash

# https://buildkite.com/docs/guides/writing-build-scripts
set -eo pipefail

echo "+++ rebuilding container"
docker build -t chizcw/hameraasfa .

echo "+++ relaunching container"
docker stop hameraasfa ||true;
docker rm hameraasfa   ||true;
docker run \
    --detach=true \
    --name=hameraasfa \
    -e VIRTUAL_HOST=hameraasfa.uk \
    chizcw/hameraasfa

echo "+++ listing most recent container"
docker ps -n=1

echo "--- listing all containers"
docker ps
