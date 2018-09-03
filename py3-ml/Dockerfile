#FROM basin/alpine-python:2.7
FROM basin/alpine-python3:latest
MAINTAINER Jiangwen Su <idleuncle@gmail.com>

COPY ./requirements.txt /tmp/requirements.txt

RUN apk add --no-cache libstdc++ lapack-dev && \
        apk add --no-cache \
        --virtual=.build-dependencies \
        gcc g++ gfortran musl-dev libxml2 libxslt libxml2-dev libxslt-dev \
        python3-dev && \
        ln -s locale.h /usr/include/xlocale.h && \
        pip install -r /tmp/requirements.txt && \
        find /usr/lib/python3.*/ -name 'tests' -exec rm -rf '{}' + && \
        rm -f /usr/include/xlocale.h && \
        rm -rf /root/.cache

RUN rm -f /tmp/requirements.txt

RUN apk del .build-dependencies
