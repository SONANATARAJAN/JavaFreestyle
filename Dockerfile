# Step 1: Use official OpenJDK image
FROM openjdk:17-jdk-slim

# Step 2: Set working directory inside container
WORKDIR /app

# Step 3: Copy Java file into container
COPY HelloWorld.java .

# Step 4: Compile Java program
RUN javac HelloWorld.java

# Step 5: Run Java program
CMD ["java", "HelloWorld"]
