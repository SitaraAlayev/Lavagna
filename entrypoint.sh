#!/bin/sh


echo "Copying static documentation files to shared volume with NGINX"
rsync -r webapp/ /tmp/static-files/webapp
rsync -r docs/ /tmp/static-files/docs

# Wait for MYSQL

while ! nc -z ${DB_HOST} ${DB_PORT}; do
    echo "Database not available, retrying in 1 sec...."
    sleep 1
done

java \
    -Ddatasource.dialect="${DB_DIALECT}" \
    -Ddatasource.url="${DB_URL}" \
    -Ddatasource.username="${DB_USER}" \
    -Ddatasource.password="${DB_PASS}" \
    -Dspring.profiles.active="${SPRING_PROFILE}" \
    -jar lavagna-jetty-console.war
