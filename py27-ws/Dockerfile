FROM basin/alpine-python:2.7

# RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.6/main" > /etc/apk/repositories
# RUN echo "http://mirrors.ustc.edu.cn/alpine/v3.6/community" >> /etc/apk/repositories

# RUN echo '[global]' >> /etc/pip.conf
# RUN echo 'index-url = https://mirrors.aliyun.com/pypi/simple' >> /etc/pip.conf

COPY . /tmp_data/

WORKDIR /tmp_data/

RUN pip install --no-cache-dir --disable-pip-version-check  -r requirements.txt

WORKDIR /

RUN rm -rf /tmp_data