# Practice: run MySQL server


1.) Install a mysql client
```shell
sudo apt install mysql-client-8.0
```
Try it out:
```shell
mysql --version
```

2.) Run mysql in docker
```shell
docker run -d -p 3306:3306 mysql
```
3.) Container status is ```Exited```
```shell
docker ps -a
```

4.) See logs of the container
```shell
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
```shell
docker run \
-d \
-p 3306:3306 \
-e MYSQL_ROOT_PASSWORD=password1234 \
-e MYSQL_DATABASE=my_main_db \
--name mysqlserver \
mysql
```

Connect to mysql write password in the prompt: password1234.
Please, wait at lest for 20 seconds and let container start.
```
mysql -u root -h 127.0.0.1 -p
```

Perform some actions in the database
```sql
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

Now all your data is stored inside _~/local-directory_
and you may restart your container any times, delete it, create new,
but with the same config: data will be safe
```shell
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

| [2. Common commands](2_common_commands_nginx.md) | [Main page](README.md) | [4. Dockerfile ](5_Dockerfile.md) |
|--------------------------------------------------|------------------------|-----------------------------------|
