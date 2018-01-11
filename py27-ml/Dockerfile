FROM basin/alpine-python:2.7
MAINTAINER Jiangwen Su <idleuncle@gmail.com>

COPY ./requirements.txt /tmp/requirements.txt

RUN apk add --no-cache libstdc++ lapack-dev && \
        apk add --no-cache \
        --virtual=.build-dependencies \
        g++ gfortran musl-dev libxml2 libxslt libxml2-dev libxslt-dev \
        python2-dev && \
        ln -s locale.h /usr/include/xlocale.h && \
        pip --no-cache-dir install numpy && \
        pip --no-cache-dir install pandas && \
        pip --no-cache-dir install scipy && \
        pip --no-cache-dir install scikit-learn && \
        find /usr/lib/python2.*/ -name 'tests' -exec rm -rf '{}' + && \
        rm -f /usr/include/xlocale.h && \
        rm -rf /root/.cache

RUN rm -f /tmp/requirements.txt

RUN apk del .build-dependencies