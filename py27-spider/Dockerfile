FROM basin/alpine-python:2.7.1

RUN echo '[global]' >> /etc/pip.conf
RUN echo 'index-url = https://mirrors.aliyun.com/pypi/simple' >> /etc/pip.conf
RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories

RUN apk add --update --no-cache curl-dev
#RUN apk add --virtual build-deps gcc openssl openssl-dev python-dev musl-dev && \
    RUN apk add postgresql-dev && \
apk add libxml2-dev libxml2 libxslt libxslt-dev

COPY . /tmp_data/

WORKDIR /tmp_data/

RUN pip install --no-cache-dir --disable-pip-version-check  -r requirements.txt

WORKDIR /

#RUN rm -rf /tmp_data




