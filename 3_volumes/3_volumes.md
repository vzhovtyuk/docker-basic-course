# Volumes

1.) Now let`s add a volume to our nginx container and serve static files from the folder.
Folder ```/usr/share/nginx/html``` is predefined to container all the static content that
should be served by nginx. Let's mount it to some local directory on out host machine:

```shell
mkdir ~/static_content
docker run -d -p 8081:80 --name webserver --rm -v ~/static_content:/usr/share/nginx/html:ro nginx:1.25.2
```

This fragment means that we map ```~/static_content``` folder on our host machine
to ```/usr/share/nginx/html``` folder inside the container.
```
... -v ~/static_content:/usr/share/nginx/html:ro ...
```


2.) ```:ro```(read-only) option means that this volume is readonly and container cannot change any data there.
There is also ```:rw```(read-write) option: it allows also to change data of files in volume and is set by default

Check that container cannot change file:
```shell
docker exec -it webserver bash
```

```shell
cd /usr/share/nginx/html
echo "Wrong data" > index.html
```
This will print such message: ```bash: index.html: Read-only file system```. If you try to do
such things from Java or some another programming language, it will lead to some type os I/O exception.

> **BEST PRACTICE:**
> use read-only(:ro) option for volumes where you don`t need to write anything 

Now you can add any files inside ```~/static_content``` folder and they will be served by nginx.

You can put ```index.html``` file in ```html``` folder of this repo inside ```~/static_content``` folder
and serve it on http://localhost:8081/index.html

Exit from interactive mode:
```
exit
```

Stop the container:
```
docker stop webserver
```
