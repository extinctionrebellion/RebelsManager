#! /bin/sh

# Wait for PostgreSQL
until nc -z -v -w30 $POSTGRES_HOST 5432
do
  echo 'Waiting for PostgreSQL...'
  sleep 1
done
echo "PostgreSQL is up and running"
