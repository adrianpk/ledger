# Vars
STG_TAG=stage
PROD_TAG=v0.0.1
IMAGE_NAME=ledger
CUR_DIR = $(CURDIR)

all:
	test build

format:
	mix format

build:
	mix compile

run:
	make setdev
	iex -S mix phx.server

setdev:
	DATABASE_URL="ecto://ledger:ledger@localhost/ledger_readstore_dev"
	export DATABASE_URL;

test-ig:
	DATABASE_URL="ecto://ledger:ledger@localhost/ledger_readstore_test"
	export DATABASE_URL;
	make -f makefile.test test-selected

# Misc
rabbitmq-start:
	docker run -d --hostname my-rabbit --name some-rabbit -p 15672:15672 -p 5672:5672 rabbitmq:3-management

# Misc
rabbitmq-restart:
	docker start some-rabbit

spacer:
	@echo "\n"

# Messages
send-receive-from-transport:
	sh $(CUR_DIR)/scripts/send/receive_from_transport.sh

send-request-shipping:
	sh $(CUR_DIR)/scripts/send/request_shipping.sh
