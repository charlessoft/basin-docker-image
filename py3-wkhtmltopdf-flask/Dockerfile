#FROM alpine:3.8
#FROM basin/alpine38_0.1
#FROM basin/alpine38:alpine38_0.1
#FROM basin/py3-flask:py3-flask_0.1
# FROM alpine:3.6
FROM basin/py3-flask:py3-flask_0.1
MAINTAINER charles <charlessoft@qq.com>

RUN echo \
&& echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/main"  > /etc/apk/repositories \
&& echo "http://dl-cdn.alpinelinux.org/alpine/v3.8/community" >> /etc/apk/repositories 

RUN apk add --update --no-cache \
libgcc libstdc++ libx11 glib libxrender libxext libintl \
libcrypto1.0 libssl1.0 \
ttf-dejavu ttf-droid ttf-freefont ttf-liberation ttf-ubuntu-font-family

# on alpine static compiled patched qt headless wkhtmltopdf (47.2 MB)
# compilation takes 4 hours on EC2 m1.large in 2016 thats why binary
COPY wkhtmltopdf /bin
COPY simsun.ttc /usr/share/fonts 

#ENTRYPOINT ["wkhtmltopdf"]
