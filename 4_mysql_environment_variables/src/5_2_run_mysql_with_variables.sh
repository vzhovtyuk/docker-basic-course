#!/bin/bash

docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
--name mysqlserver \
mysql