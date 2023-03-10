
FROM openjdk:8-jdk-alpine


WORKDIR /app


COPY pom.xml .


RUN ["mvn", "dependency:resolve", "clean", "verify", "package", "-DskipTests"]


COPY src/ ./src/


RUN ["mvn", "clean", "package", "-DskipTests"]
CMD ["java", "-jar", "target/jb-hello-world-maven-0.2.0.jar"]