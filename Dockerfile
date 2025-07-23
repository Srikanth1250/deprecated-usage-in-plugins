# Stage 1: Build the Jenkins plugin
FROM maven:3.9.6-eclipse-temurin-17 AS builder

# Install required packages
RUN apt-get update && apt-get install -y git zip

# Set work directory
WORKDIR /app

# Copy project files
COPY . .

# Build the Jenkins plugin
RUN mvn clean package

# Stage 2: Create a minimal runtime image (if you want to run Jenkins with this plugin)
FROM jenkins/jenkins:lts

# Copy the built .hpi plugin to Jenkins plugins directory
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Skip setup wizard for easier dev
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false
