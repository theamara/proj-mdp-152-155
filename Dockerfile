# Stage 1: Maven build
FROM maven:3.8.5-openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2: Tomcat runtime
FROM tomcat:9-jdk17
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/app.war
EXPOSE 8080
