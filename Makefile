.PHONY: default help start down attach create-topic list-topics describe-topics delete-topic

zookeeper_host = zookeeper:2181
partition ?= 1
replica ?= 1

default: help

help:
	@echo 'Usage:'
	@echo '    make help                 Show help'
	@echo '    make start                Usage: make start'
	@echo '    make stop                 Usage: make stop'
	@echo '    make attach               Usage: make attach'
	@echo '    make create-topic         Usage: make create-topic topic={topic_name} partition={number} replica={number}'
	@echo '    make list-topics          Usage: make list-topics'
	@echo '    make describe-topics      Usage: make describe-topic topic={topic_name}'
	@echo '    make delete-topic         Usage: make delete-topic topic={topic_name}'

start:
	@docker-compose up -d

stop:
	@docker-compose down

attach:
	@./attach_kafka.sh

create-topic:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --create --topic $(topic)  -zookeeper ${zookeeper_host} --partitions $(partition) --replication-factor $(replica)

list-topics:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --list --zookeeper ${zookeeper_host}

describe-topics:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --describe --topic $(topic) --zookeeper ${zookeeper_host}

delete-topic:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --zookeeper ${zookeeper_host} --delete --topic $(topic)

