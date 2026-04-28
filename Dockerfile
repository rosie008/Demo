FROM amazoncorretto:25-alpine

RUN mkdir -p /app
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} /app/demo.jar
WORKDIR /app

ENTRYPOINT ["java","-jar","demo.jar"]