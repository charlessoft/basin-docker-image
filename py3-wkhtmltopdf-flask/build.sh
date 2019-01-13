#!/bin/bash
image_name=basin/${PWD##*/}
echo $image_name
version=latest
#docker build -t -python:2.7 .

function build(){
	if [ ! -n "$1" ] ;then
		version=latest
	else
		version=$1
	fi
	echo 'build version:' $version
	docker build -t $image_name:$version .
	# docker tag $image_name:$version 127.0.0.1:5006/$image_name:$version
	# docker push 127.0.0.1:5006/$image_name:$version


}

build $*

#make build_all

