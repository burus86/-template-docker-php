FROM rabbitmq:3.6.1-management

MAINTAINER montolsaklor@gmail.com

COPY rabbitmqadmin /usr/local/bin/rabbitmqadmin

RUN apt-get update -y && apt-get install -y python && \
    chmod +x /usr/local/bin/rabbitmqadmin &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /
