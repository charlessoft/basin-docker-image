FROM basin/alpine-jdk8:alpine-jdk8_0.1

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
  && pip3 install --upgrade pip setuptools\
  && if [[ ! -e /usr/bin/pip ]]; then ln -sf /usr/bin/pip3 /usr/bin/pip; fi \
  && rm -fr /root/.cache \
  && echo
COPY ./requirements.txt /tmp/requirements.txt
RUN pip install -r /tmp/requirements.txt 
RUN rm -fr /tmp/requirements.txt



# since we will be "always" mounting the volume, we can set this up
ENTRYPOINT ["/usr/bin/dumb-init"]
CMD ["python"]

