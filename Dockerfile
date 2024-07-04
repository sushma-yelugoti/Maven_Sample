FROM maven:3.6.0-jdk-11-slim AS build
COPY src /usr/src/app/src
COPY pom.xml /usr/src/app
RUN mvn -f /usr/src/app/pom.xml clean package

# Install chromedriver for Selenium
RUN curl https://storage.googleapis.com/chrome-for-testing-public/126.0.6478.126/mac-arm64/chromedriver-mac-arm64.zip -o /usr/local/bin/chromedriver
RUN chmod +x /usr/local/bin/chromedriver

#
# PACKAGE STAGE
#
FROM openjdk:11-jre-slim 
COPY --from=build /usr/src/app/target/Maven_sample-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/app/demo-0.0.1-SNAPSHOT.jar
EXPOSE 8080  
CMD ["java","-jar","/usr/app/demo-0.0.1-SNAPSHOT.jar"]