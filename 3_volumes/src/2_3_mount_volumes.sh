#!/bin/bash
# type of the mount, which can be bind, volume, or tmpfs
docker run -d \
  -it \
  --name devtest \
  --mount type=bind,source="$(pwd)"/target,target=/app \
  nginx:latest

docker inspect devtest

docker container stop devtest

docker container rm devtest
