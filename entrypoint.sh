#!/bin/sh

java \
    -Ddatasource.dialect="${DB_DIALECT}" \
    -Ddatasource.url="${DB_URL}" \
    -Ddatasource.username="${DB_USER}" \
    -Ddatasource.password="${DB_PASS}" \
    -Dspring.profiles.active="${SPRING_PROFILE}" \
    -jar lavagna-jetty-console.war
