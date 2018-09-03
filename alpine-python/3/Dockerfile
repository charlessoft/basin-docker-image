FROM alpine:3.6

# copy from https://github.com/jfloff/alpine-python

ENV ALPINE_VERSION=3.6

# Install needed packages. Notes:
#   * dumb-init: a proper init system for containers, to reap zombie children
#   * musl: standard C library
#   * linux-headers: commonly needed, and an unusual package name from Alpine.
#   * build-base: used so we include the basic development packages (gcc)
#   * bash: so we can access /bin/bash
#   * git: to ease up clones of repos
#   * ca-certificates: for SSL verification during Pip and easy_install
#   * python: the binaries themselves
#   * python-dev: are used for gevent e.g.
#   * py-setuptools: required only in major version 2, installs easy_install so we can install Pip.
ENV PACKAGES="\
  dumb-init \
  mariadb-dev \
  musl \
  linux-headers \
  build-base \
  bash \
  git \
  ca-certificates \
  python3 \
  python3-dev \
  py-setuptools \
  curl \
  tzdata \
  mariadb-client \
"

RUN echo \
  # replacing default pip  with edge ones
  apk add --upgrade apk-tools@edge \
  && echo '[global]' >> /etc/pip.conf \
  && echo 'index-url = https://pypi.tuna.tsinghua.edu.cn/simple/' >> /etc/pip.conf \
  # replacing default repositories with edge ones
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/main" >> /etc/apk/repositories \
  # Add the packages, with a CDN-breakage fallback if needed
  && apk add --no-cache $PACKAGES || \
    (sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories && apk add --no-cache $PACKAGES) \
  # turn back the clock -- so hacky!
  # && echo "http://mirrors.ustc.edu.cn/alpine/v$ALPINE_VERSION/main/" > /etc/apk/repositories \
  # make some useful symlinks that are expected to exist
  && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python3-config /usr/bin/python-config; fi \
  && rm -fr /usr/bin/python ; ln -sf /usr/bin/python3 /usr/bin/python \
  # Install and upgrade Pip
  && python3 -m ensurepip \
  && rm -r /usr/lib/python*/ensurepip \
  && pip3 install --upgrade pip setuptools \
  && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip3 /usr/bin/pip; fi \
  && rm -r /root/.cache \

  && echo
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt 
RUN rm -fr /tmp/requirements.txt


RUN  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
  && echo "Asia/Shanghai" > /etc/timezone


# since we will be "always" mounting the volume, we can set this up
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["python"]
