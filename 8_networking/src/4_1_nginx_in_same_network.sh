#!/bin/bash

docker run --rm -d --name nginx-in-same-network --net=petclinic-custom-net nginx:1.25



