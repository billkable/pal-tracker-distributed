#!/bin/bash

## Setup RabbitMQ locally

docker run -d --hostname rmq --name rmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management
docker exec -it rmq rabbitmq-plugins enable rabbitmq_tracing

## Setup RabbitMQ on TAS

cf cs p-rabbitmq standard project-event-broker

