FROM centos:7.6.1810
#FROM  basin/alpine3.17:latest

MAINTAINER chenqian <charlessoft@qq.com>

ENV TZ='Asia/Shanghai'

ENV PACKAGES="\
tzdata \
"

#run echo 219.76.4.4 s3.amazonaws.com >> /etc/hosts \
#    && echo 219.76.4.4 github-cloud.s3.amazonaws.com >> /etc/hosts


RUN yum install unzip xz-devel mesa-libGL python-backports-lzma  zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gcc gcc-c++ make libffi-devel -y \
&& yum install wget -y \
&& wget https://www.python.org/ftp/python/3.8.1/Python-3.8.1.tgz \
&& tar -zxvf Python-3.8.1.tgz  \
&& cd Python-3.8.1 \
&& ./configure prefix=/usr/local/python3 \
&& make && make install 

RUN echo export PATH=${PATH}:/usr/local/python3/bin >> /etc/profile \
&& source /etc/profile \
&& /usr/local/python3/bin/pip3 install --upgrade pip \
&& yum clean headers  \
&& yum clean packages \
&& yum clean metadata \
&& rm -fr Python-3.8.1.tgz Python-3.8.1 




#
#RUN \
#yum provides libstdc++.so.6 \
#&& cd /usr/local/lib64 \
#&& wget http://www.vuln.cn/wp-content/uploads/2019/08/libstdc.so_.6.0.26.zip \
#&& unzip libstdc.so_.6.0.26.zip \
#&& cp libstdc++.so.6.0.26 /usr/lib64 \
#&& cd  /usr/lib64 \
#&& rm -fr libstdc++.so.6 \
#&& ln -s libstdc++.so.6.0.26 libstdc++.so.6 \
#
#RUN \
#/usr/local/python3/bin/pip3 install paddlepaddle \
#&& /usr/local/python3/bin/pip3 install pytest-runner \
#&& /usr/local/python3/bin/pip3 install paddlespeech
