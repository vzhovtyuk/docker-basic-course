#!/bin/bash

docker run --rm -d --name nginx-in-another-network --net=another-custom-net nginx:1.25



