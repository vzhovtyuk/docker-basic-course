#!/bin/bash

docker exec -it nginx-in-another-network bash

apt update -y
apt install -y iputils-ping
ping petclinic
exit



