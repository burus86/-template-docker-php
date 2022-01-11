#!/bin/bash

/usr/local/bin/rabbitmqadmin declare user --user=${RABBITMQ_DEFAULT_USER} --password=${RABBITMQ_DEFAULT_PASS} --host=${RABBIT_HOST} name=${RABBITMQ_SUB_USER} password=${RABBITMQ_SUB_PASS} tags=${RABBITMQ_TAG}
/usr/local/bin/rabbitmqadmin declare permission --user=${RABBITMQ_DEFAULT_USER} --password=${RABBITMQ_DEFAULT_PASS} vhost=${RABBITMQ_DEFAULT_VHOST} --host=${RABBIT_HOST} user=${RABBITMQ_SUB_USER} configure=.* read=.* write=.*
