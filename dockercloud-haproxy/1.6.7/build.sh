#!/bin/bash
image_name=basin/haproxy
version=latest
#docker build -t -python:2.7 .

containerlist=$(docker ps -a -q)
for container in ${containerlist[@]}
do
    docker rm -f $container
done

imagelist=$(docker images -q)
for image in ${imagelist[@]}
do
    docker rmi -f $image
done

docker build -t $image_name:$version .
docker tag $image_name:$version 127.0.0.1:5006/$image_name:$version
docker push 127.0.0.1:5006/$image_name:$version

