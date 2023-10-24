#!/bin/bash

docker service create --name my-nginx-service --replicas 3 nginx:1.25

