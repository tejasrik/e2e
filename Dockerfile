FROM openjdk:12-alpine
ADD target/springboot-example.jar app.jar
ENTRYPOINT ["java","-jar","app.jar"]
