# 8. Working with remote repositories in Docker


0.) Create an account on https://hub.docker.com

1.) Login to DockerHub from docker CLI.

Run this command and then type in a password.

```shell
docker login --username <your username>
```
2.) To push docker image to remote repository it is necessary to tag it using name
pattern like this: ```<your username>/<image_name>:<version>```

```shell
docker tag petclinic:latest <your_username>/petclinic:latest
```
This command creates a copy of already existing ```petclinic:latest``` image, but with new name

3.) See new image in list:
```shell
docker images | grep petclinic
```

4.) Run the following command to push image to remote repository

```shell
docker push <your username>/petclinic:latest
```

5.) Now everybody is able to pull your image using command:
```shell
docker pull <your username>/petclinic:latest
```


| [5. Dockerfile](5_Dockerfile.md) | [Main page](README.md) | [7. Docker Compose](7_docker_compose.md)) |
|----------------------------------|------------------------|-------------------------------------------|
