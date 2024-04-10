# Use an official OpenJDK runtime as a parent image
FROM maven:latest

# Set the working directory inside the container
WORKDIR /app

# Copy the compiled JAR file from your target directory into the container
COPY Backend-Spring-Boot/target/soulfulplates-0.0.1-SNAPSHOT.jar app/app.jar

# Expose the port on which your Spring Boot application will run (adjust as needed)
EXPOSE 8080

# CMD ["ls"]

# CMD ["pwd"]

# Define the command to run your Spring Boot application when the container starts
ENTRYPOINT ["java", "-jar", "./app/app.jar"]
