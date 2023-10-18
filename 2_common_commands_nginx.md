# Common commands, image and container management

1.) To see some information about the running and the stopped
containers run:
```shell
docker ps -a
```
Without flag -a (--all) shows only running containers, but with it - all of them (also stopped)


2.) This command removes a container or image from docker's local storage.
Let's remove hello-world container:

```shell
docker rm <container_id>
```
> **HINT:**
> most commands you will see later in our course operate with both **container/image id**
> and **container/image name**.

> **HINT:**
> It is possible not to write the whole **id** of container/image: Docker is smart enough
> to understand which container/image you are needed from several first letters of **id**.
> So you may write
> ```
> docker stop ddc
> ``` 
> instead of
> ```
> docker stop ddc84aa5e904
> ```
>
> Just make sure this id prefix uniquely identifies certain container/image


3.) This command shows the list of images
```shell
docker images
```

4.) Remove the hello-world image by full name or id
```shell
docker rmi hello-world:latest
```

5.) Pull the docker image manually. If no tag specified, an image with tag ```:latest``` will be downloaded
```shell
docker pull nginx
docker pull tomcat:8.5.93
```

6.) Runs docker container in detached mode (background process) and
forwards ports: it maps port **80 inside** the nginx container to **8081 outside** it.
Without port forwarding it will be no access to container from localhost.
* ```--name``` gives container a certain name
* ```--rm``` removes container after it is stopped (useful for demo)
* ```-d (--detach)``` runs container in detached mode
* ```-p (--publish)``` maps a port on your host machine to a port on the container

```shell
docker run -d -p 8081:80 --name webserver --rm nginx:1.25.2
```

Run ```docker ps``` to see the info about the container.

7.) Go inside the container and see that is a simple linux OS:

This command will run ```uname -a``` script **inside** a ```webserver``` container
&rarr; this will print the Linux distro version of container
```shell
docker exec webserver uname -a
```

The run this command to attach to container:
```shell
docker exec -it webserver bash
```
* ```-it``` executes a command in interactive mode and executing
  bash we can perform then any actions


Let's update apt packages installed inside the container and install nano console editor:
That is a **bad practice** to install something inside a container, but for demo purposes - that is ok.

```shell
apt update
apt install -y nano
```

Go to predefined directory of nginx and change a bit file ```index.html```:

```shell
cd /usr/share/nginx/html
```
After saving ```index.html``` nginx welcome page will be changed.

Run ```exit``` to exit from container's terminal

Stop nginx container using command
```shell
docker stop webserver
```

| [1. Docker installation](1_docker_installation.md) | [Main page](README.md) | [3. MySQL and environment variables ](3_volumes.md) |
|----------------------------------------------------|------------------------|-----------------------------------------------------|

