#!/bin/bash

set -e
set -u

function create_user_and_database() {
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE DATABASE $1;
EOSQL
}

if [ -n "$POSTGRES_MULTIPLE_DATABASES" ]; then
	for db in $(echo $POSTGRES_MULTIPLE_DATABASES | tr ',' ' '); do
		create_user_and_database $db
	done
fi