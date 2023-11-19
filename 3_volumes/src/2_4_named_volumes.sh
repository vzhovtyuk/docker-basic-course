#!/bin/bash
# type of the mount, which can be bind, volume, or tmpfs
docker volume create my-vol

docker volume ls

docker volume inspect my-vol

docker run -d \
  --name devtest \
  --mount source=my-vol,target=/app \
  nginx:latest


docker volume rm my-vol
