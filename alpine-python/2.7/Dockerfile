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
  musl \
  linux-headers \
  build-base \
  bash \
  git \
  ca-certificates \
  python2 \
  python2-dev \
  py-setuptools \
  curl \
  tzdata \
"

RUN echo \
  # replacing default pip  with edge ones
  && echo '[global]' >> /etc/pip.conf \
  && echo 'index-url = https://mirrors.aliyun.com/pypi/simple' >> /etc/pip.conf \
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
  && if [[ ! -e /usr/bin/python ]];        then ln -sf /usr/bin/python2.7 /usr/bin/python; fi \
  && if [[ ! -e /usr/bin/python-config ]]; then ln -sf /usr/bin/python2.7-config /usr/bin/python-config; fi \
  && if [[ ! -e /usr/bin/easy_install ]];  then ln -sf /usr/bin/easy_install-2.7 /usr/bin/easy_install; fi \
  # Install and upgrade Pip
  && easy_install pip \
  && pip install --upgrade pip \
  && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip2.7 /usr/bin/pip; fi \
  && echo

RUN  ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \ 
  && echo "Asia/Shanghai" > /etc/timezone


# since we will be "always" mounting the volume, we can set this up
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["python"]
