FROM python:3.7.7-alpine
#MAINTAINER dotneter


RUN echo 'http://mirrors.aliyun.com/alpine/v3.5/main' > /etc/apk/repositories \
    && echo 'http://mirrors.aliyun.com/alpine/v3.5/community' >>/etc/apk/repositories \
    && apk update && apk add tzdata \
    && ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && echo "Asia/Shanghai" > /etc/timezone

COPY requirements.txt /tmp/requirements.txt
RUN pip3 config set global.index-url http://mirrors.aliyun.com/pypi/simple \
    && pip3 config set install.trusted-host mirrors.aliyun.com \
    && pip3 install -r /tmp/requirements.txt

RUN mkdir /app
VOLUME ["/app"]
#COPY . /app
WORKDIR /app


CMD ["/usr/local/bin/python3","-u","/app/renew.py"]
