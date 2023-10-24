#!/bin/bash

docker service update --image nginx:1.25.1 my-nginx-service
docker service ls

