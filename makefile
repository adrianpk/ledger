# Vars
STG_TAG=stage
PROD_TAG=v0.0.1
IMAGE_NAME=ledger

all:
	test build

format:
	mix format

build:
	mix compile

setdev:
	DATABASE_URL="ecto://ledger:ledger@localhost/ledger_readstore_dev"
	export DATABASE_URL;

test-ig:
	DATABASE_URL="ecto://ledger:ledger@localhost/ledger_readstore_test"
	export DATABASE_URL;DATABASE_URL="ecto://ledger:ledger@localhost/ledger_readstore_test"
	make -f makefile.test test-selected

spacer:
	@echo "\n"
