.PHONY: default help start down attach create-topic list-topics describe-topic delete-topic

zookeeper_host = zookeeper:2181
partition ?= 1
replica ?= 1

.PHONY: default
default: help

.PHONY: help
help:
	@echo 'Usage:'
	@echo '    make help                 Show help'
	@echo '    make start                Usage: make start'
	@echo '    make start-sasl           Usage: make start-sasl'
	@echo '    make status               Usage: make statu's
	@echo '    make status-sasl          Usage: make status-sasl'
	@echo '    make stop                 Usage: make stop'
	@echo '    make stop-sasl            Usage: make stop-sasl'
	@echo '    make attach               Usage: make attach'
	@echo '    make create-topic         Usage: make create-topic topic={topic_name} partition={number} replica={number}'
	@echo '    make list-topics          Usage: make list-topics'
	@echo '    make describe-topic       Usage: make describe-topic topic={topic_name}'
	@echo '    make delete-topic         Usage: make delete-topic topic={topic_name}'

.PHONY: start
start:
	@docker-compose -f docker-compose.yml up -d

.PHONY: start-sasl
start-sasl:
	@docker-compose -f docker-compose-sasl.yml up -d

.PHONY: status
status:
	@docker-compose -f docker-compose.yml ps

.PHONY: status-sasl
status-sasl:
	@docker-compose -f docker-compose-sasl.yml ps

.PHONY: stop
stop:
	@docker-compose -f docker-compose.yml down

.PHONY: stop-sasl
stop-sasl:
	@docker-compose -f docker-compose-sasl.yml down

.PHONY: attach
attach:
	@./attach_kafka.sh

.PHONY: create-topic
create-topic:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --create --topic $(topic)  -zookeeper ${zookeeper_host} --partitions $(partition) --replication-factor $(replica)

.PHONY: list
list-topics:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --list --zookeeper ${zookeeper_host}

.PHONY: describe-topic
describe-topic:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --describe --topic $(topic) --zookeeper ${zookeeper_host}

.PHONY: delete-topic
delete-topic:
	@docker exec kafka_2.12-2.3.0 kafka-topics.sh --zookeeper ${zookeeper_host} --delete --topic $(topic)

