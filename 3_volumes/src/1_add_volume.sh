#!/bin/bash

mkdir ~/static_content
docker run -d -p 8081:80 --name webserver --rm -v ~/static_content:/usr/share/nginx/html:ro nginx:1.25.2