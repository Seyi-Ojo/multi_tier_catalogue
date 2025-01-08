FROM eclipse-temurin:17-jdk-alpine

# Add basic utilities
RUN apk add --no-cache curl

WORKDIR /app

# Copy only the files needed for dependency resolution first
COPY mvnw .
COPY .mvn .mvn
COPY pom.xml .

# Make mvnw executable
RUN chmod +x mvnw

# Copy the source code
COPY src src

# Package the application
RUN ./mvnw package -DskipTests

EXPOSE 8080
ENTRYPOINT ["java","-jar","/app/target/web_ui-0.0.1-SNAPSHOT.jar"] 