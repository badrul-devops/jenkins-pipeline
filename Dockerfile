
FROM openjdk:8-jdk-alpine

RUN apk add --no-cache curl tar bash

# Install Maven
ARG MAVEN_VERSION=3.6.3
ARG USER_HOME_DIR="/root"
ARG SHA=8e9a0273b23ef5b65f16b8af50f763d34d39a1e784c0cb8bc9b0c0716a11b063
RUN mkdir -p /usr/share/maven \
  && curl -fsSL https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz \
    | tar -xzC /usr/share/maven --strip-components=1 \
  && ln -s /usr/share/maven/bin/mvn /usr/bin/mvn

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG "$USER_HOME_DIR/.m2"

# Copy the application JAR file to the container
COPY target/jb-hello-world-maven-0.2.0.jar /app/

# Set the working directory
WORKDIR /app

# Expose the application port
EXPOSE 8080

# Run the application
CMD ["java", "-jar", "jb-hello-world-maven-0.2.0.jar"]
