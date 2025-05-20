#!/bin/bash
until mysqladmin ping -hmysql -uroot -p1234 --silent; do
  echo "Waiting for MySQL to be reachable..."
  sleep 2
done

# Wait for the database to be fully initialized
until mysql -hmysql -uroot -p1234 -e "SELECT 1 FROM DUAL;" >/dev/null 2>&1; do
  echo "Waiting for MySQL database to be fully initialized..."
  sleep 2
done

echo "MySQL is ready!"
exec "$@"