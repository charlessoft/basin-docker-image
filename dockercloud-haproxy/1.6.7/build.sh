#!/bin/bash
image_name=basin/haproxy
version=latest
#docker build -t -python:2.7 .


docker build -t $image_name:$version .
docker tag $image_name:$version 127.0.0.1:5006/$image_name:$version
docker push 127.0.0.1:5006/$image_name:$version

