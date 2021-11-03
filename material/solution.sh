#!/bin/bash

## Containers Life Cycle:
# 1/
sudo docker create --name ex1-1 -p 8085:80 wordpress:latest
# 2/
sudo docker start ex1-1
# 3/
sudo docker stop ex1-1
sudo docker rm ex1-1
# 4/
sudo docker run --name ex1-4 -p 8086:80 -d wordpress:latest
# 5/
sudo docker container stats ex1-4
# 6/
sudo docker container inspect ex1-4 | grep -A 10 Mounts
# 7/
sudo docker pause ex1-4
curl localhost:8086 &
sudo docker unpause ex1-4
sudo docker stop ex1-4
sudo docker rm ex1-4

## Containers Storage:
# 1/
sudo docker create --name ex2-1 -p 8087:80 -v ~/data:/usr/share/nginx/html nginx:latest
sudo docker run ex2-1
# 2/ 
sudo nano data/index.html
# 3/
# visit <host_ip_address>:8087
sudo docker stop ex2-1
sudo docker rm ex2-1
# 4/
sudo docker volume create nginx-vol
sudo docker volume inspect nginx-vol
# 5/
sudo docker create --name ex2-5 -p 8088:80 -v nginx-vol:/usr/share/nginx/html nginx:latest
# 6/
# visit <host_ip_address>:8088
sudo nano /var/lib/docker/volumes/nginx-vol/_data/index.html
# visit <host_ip_address>:8088
# 7/
sudo docker create --name ex2-7 -p 8089:80 -v nginx-vol:/usr/share/nginx/html nginx:latest
# visit <host_ip_address>:8089
# 8/
sudo docker stop ex2-5 ex2-7
sudo docker rm ex2-5 ex2-7
# 9/
sudo docker volume ls
sudo docker volume rm nginx-vol

## Containers Network:
# 0/
sudo docker network ls
sudo docker inspect bridge
sudo docker inspect host
sudo docker inspect none
# 1/
sudo docker run -d --name ex3-2 wordpress
# 2/
sudo docker network create my-net
# 3/
sudo docker network connect my-net ex3-2
# 4/
sudo docker run -d --name db --network my-net -e MYSQL_ROOT_PASSWORD=pass mysql:latest
# 5/
sudo docker stats ex3-2
# 6/
sudo docker exec -it ex3-2 /bin/bash
apt update && apt install -y iputils-ping default-mysql-client
ping db
apt update && apt install -y iputils-ping
mysql -h db -uroot -ppass
exit
exit
# 7/
sudo docker network disconnect my-net ex3-2
sudo docker exec -it ex3-2 /bin/bash
ping db
exit
# 8/
sudo docker rm -f ex3-2 db
sudo docker network my-net
