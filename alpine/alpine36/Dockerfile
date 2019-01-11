FROM alpine:3.6

MAINTAINER chenqian <charlessoft@qq.com>

ENV TZ='Asia/Shanghai'

ENV PACKAGES="\
tzdata \
"

RUN echo \
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/testing" > /etc/apk/repositories \
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/community" >> /etc/apk/repositories \
  && echo "http://mirrors.ustc.edu.cn/alpine/edge/main" >> /etc/apk/repositories \
  # Add the packages, with a CDN-breakage fallback if needed
  && apk add --no-cache $PACKAGES || \
    (sed -i -e 's/dl-cdn/dl-4/g' /etc/apk/repositories && apk add --no-cache $PACKAGES)  

RUN ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && echo "$TZ" > /etc/timezone \
    &&rm -rf /var/cache/apk/* /tmp/* /var/tmp/* $HOME/.cache ## 清除缓存

