#!/bin/bash

docker service scale my-nginx-service=5
docker service ls

