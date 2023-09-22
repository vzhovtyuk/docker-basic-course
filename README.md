# Docker installation
1.) Set up Docker's apt repository
```
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

2.) Install the Docker packages
```
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3.) Create the docker group
```
sudo groupadd docker
```

> **NB:** Group 'docker' may already exist after docker installation, that is ok

4.) Add your user to the docker group
```
sudo usermod -aG docker $USER
```

5.) Log out and log back in so that your group membership is re-evaluated
> **Warning:** If you're running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

6.) Check whether docker has been installed and its version

```
docker --version
```

7.) Check whether docker deamon is up and running

```
service docker status
```

8.) Run hello-world container

```
docker run hello-world
```

We just ran a container based on the hello-world Docker Image, as
we did not have the image locally, docker pulled the image from the
DockerHub and then used that image to run the container.
All that happened was:
* the container ran
* printed some text on the screen
* and then exited.


* https://docs.docker.com/engine/install/ubuntu/ - install docker on ubuntu
* https://docs.docker.com/engine/install/linux-postinstall/ - how to run docker as a non-root user

# Start working!

1.) To see some information about the running and the stopped
containers run: 
```
docker ps -a
```
Without flag -a (--all) shows only running containers, but with it - all of them (also stopped)


2.) This command removes a container or image from docker`s local storage 
some first symbols of id is enough
> **NB:** container must be stopped before removing

```
docker rm <container_id>
```


3.) This command shows the list of images
```
docker images
```

4.) Remove the image by id
```
docker rmi <image_id>
```
> **Hint:** when working with images or containers only several first symbols of **Id** are needed to identify the image or container

> **Hint:** when working with images or containers you may use **Id** and **Name** interchangeably.
> So ```docker rmi <image_name>``` will give the same result


5.) Pull the docker image manually. If no tag specified, an image with tag ```:latest``` will be downloaded 
```
docker pull alpine
docker pull ubuntu:20.04
```

6.) This command runs container and stops just right after start
because it does not do anything, so process is
running inside it
```
docker run ubuntu
```

runs docker container in daemon mode == background process
```
docker run -d ubuntu sleep 5
```

starts already created container, which is stopped.
does NOT create a new one!
```
docker start <container_id | container_name>
docker stop <container_id | container_name>
```

# Practice: run MySQL server


1.) Install a mysql client
```
sudo apt install mysql-client-8.0
```
Try it out:
```
mysql --version
```

2.) Run mysql in docker
```
docker run -d -p 3306:3306 mysql
```
3.) Container status is ```Exited```
```
docker ps -a
```

4.) See logs of the container
```
docker logs <container_id>
```

You will see something like this:

```
2023-09-20 10:34:24+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.1.0-1.el8 started.
2023-09-20 10:34:25+00:00 [Note] [Entrypoint]: Switching to dedicated user 'mysql'
2023-09-20 10:34:25+00:00 [Note] [Entrypoint]: Entrypoint script for MySQL Server 8.1.0-1.el8 started.
2023-09-20 10:34:25+00:00 [ERROR] [Entrypoint]: Database is uninitialized and password option is not specified
You need to specify one of the following as an environment variable:
- MYSQL_ROOT_PASSWORD
- MYSQL_ALLOW_EMPTY_PASSWORD
- MYSQL_RANDOM_ROOT_PASSWORD
```

5.) Delete already created container
```
docker rm <container_id>
```

Specify password using env variable MYSQL_ROOT_PASSWORD
```
docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
--name mysqlserver \
mysql
```

Connect to mysql (!!! NO space after '-p' flag)
write password in the prompt: password1234
```
mysql -u root -h 127.0.0.1 -p
```

Perform some actions in the database
```
SHOW DATABASES;
USE my_main_db;
CREATE TABLE person(id int primary key, name varchar(255));
SHOW TABLES;
INSERT INTO person (id, name) VALUES (1, "Jake");
SELECT * FROM person;
exit;
```



Stop and remove container -> data will be lost (it has been storing inside the container itself)
```
docker stop mysqlserver
docker rm mysqlserver
```

Now all your data is stored inside ~/local-directory
and you may restart your container any times, delete it, create new, 
but with the same config: data will be safe
```
docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
-v ~/local-directory:/var/lib/mysql \
--name mysqlserver \
mysql
```

Do something with this database, perform some scripts...

Cleanup:
```
docker stop mysqlserver
docker rm mysqlserver
```

# Dockerfile: building your own images

1.) Create a directory for express.js project
```
cd ~
mkdir js-project
cd ./js-project
```

Create in directory js-project file 'index.js'
```
console.log("Hello, from Docker!:)");
```

1.) Dockerfile example

Create a file with name Dockerfile (without extension) inside express-js-project directory 

```
touch Dockerfile
```

Put this script inside file Dockerfile

```
FROM node:18

WORKDIR /app

COPY index.js ./

ENTRYPOINT ["node", "index.js"]
```

Run this command inside js-project directory
```
docker build . -t js-hello-world-app
```

Run container
```
docker run js-hello-world-app
```

# Docker-compose

