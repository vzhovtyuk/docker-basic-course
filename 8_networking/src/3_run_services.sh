#!/bin/bash

# mysql
docker run --rm -d \
--name mysql-server \
--net petclinic-custom-net \
-e MYSQL_ROOT_PASSWORD=password \
-e MYSQL_USER=petclinic \
-e MYSQL_PASSWORD=petclinic \
-e MYSQL_DATABASE=petclinic \
-p 3306:3306 \
mysql:8.0

# petclinic
docker run --rm -d \
--name petclinic \
--net petclinic-custom-net \
-e SPRING_PROFILES_ACTIVE=default,mysql \
-e MYSQL_URL=jdbc:mysql://mysql-server/petclinic \
-e MYSQL_USER=petclinic \
-e MYSQL_PASSWORD=petclinic \
-p 9000:8080 \
petclinic:latest

