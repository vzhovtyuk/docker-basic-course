# Docker installation
1.) Set up Docker's apt repository
```shell
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
```shell
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

3.) Create the docker group
```shell
sudo groupadd docker
```

> **NB:** Group 'docker' may already exist after docker installation, that is ok

4.) Add your user to the docker group
```shell
sudo usermod -aG docker $USER
```

5.) Log out and log back in so that your group membership is re-evaluated
> **Warning:** If you're running Linux in a virtual machine, it may be necessary to restart the virtual machine for changes to take effect.

6.) Check whether docker has been installed and its version

```shell
docker --version
```

7.) Check whether docker deamon is up and running

```shell
service docker status
```

8.) Run hello-world container

```shell
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


| [Agenda](README.md) | [Main page](README.md) | [2. Common commands](2_common_commands_nginx.md) |
|---------------------|------------------------|--------------------------------------------------|


