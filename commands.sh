# 1
# check whether docker has been installed and its version
docker --version

# 2
# check whether docker deamon is up and running
service docker status

# 3
# run hello-world container
docker run hello-world

# We just ran a container based on the hello-world Docker Image, as
# we did not have the image locally, docker pulled the image from the
# DockerHub and then used that image to run the container. 
# All that happened was: 
# * the container ran 
# * printed some text on the screen
# * and then exited.


# Then to see some information about the running and the stopped
# containers run:
docker ps -a  # ps == 'process status'
# Without flag -a (--all) shows only running containers, 
# but with it - also stopped.


# this command removes a container or image from docker`s local storage
# some first symbols of id is enough
# ! conatiner must be stopped before removing.
docker rm <container_id | image_id>


# thease commands do the same: show the list of images
docker images 
docker image ls


# remove the image by id
# some first symbols of id is enough
docker rmi <image_id>


# pull the docker image manually
# if no tag specified, download the image with tag ':latest'
docker pull alpine
docker pull ubuntu:20.04

# runs container and stops just right after start
# because it does not do anything, so process is
# running inside it
docker run ubuntu

# this command forces container to sleep anyway for 5 seconds
# is used just for demo and testing purposes
docker run ubuntu sleep 5

# runs docker container in deamon mode == background process
docker run -d ubuntu sleep 5

# starts already created container, which is stopped.
# does NOT create a new one!
docker start <container_id | container_name>

docker stop <container_id | container_name>

# This will remove all stopped containers
docker container prune 

# view the information about conatiner
docker inspect <container_id>

# view the container system resources consumption
docker stats <container_id(optional)>

# some containers do not stop just after they started, like hello-world
# some of them stay working (DB-servers, htt-servers and so on)
# let us run NGINX container and remove it then

docker pull nginx # pulling image from 


docker images list
