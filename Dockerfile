# Build stage
FROM maven:3.8.2-openjdk-11 AS build
COPY ./ /home/app
RUN cd /home/app/ && mvn clean package spring-boot:repackage
WORKDIR /home/app

#
# Package stage
#
FROM openjdk:11
COPY --from=build /home/app /home/app
COPY --from=build /home/app/target/spring-blog.jar /home/app/app.jar
EXPOSE 8080
WORKDIR /home/app
VOLUME ["/home/app"]
ENTRYPOINT ["java","-jar","/home/app/app.jar","--spring.profiles.active=prd"]