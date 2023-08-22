FROM maven:3.6.3-openjdk-8 as maven-build

WORKDIR /build
COPY LICENSE-GPLv3.txt pom.xml ./
COPY src src
RUN mvn clean install

FROM openjdk:8-jdk-alpine

RUN apk update && \
    apk add --no-cache rsync

EXPOSE 8080
ENV DB_DIALECT HSQLDB
ENV DB_URL jdbc:hsqldb:file:lavagna
ENV DB_USER sa
ENV DB_PASS ""
ENV SPRING_PROFILE dev

WORKDIR /app

COPY --from=maven-build /build/target/lavagna/help ./docs
COPY --from=maven-build /build/src/main/webapp ./webapp
COPY --from=maven-build /build/target/lavagna-jetty-console.war .
COPY entrypoint.sh .
RUN chmod +x entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]




