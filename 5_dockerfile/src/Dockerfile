FROM eclipse-temurin:17-ubi9-minimal

WORKDIR /app

ARG JAR_FILE=target/*.jar

COPY ${JAR_FILE} backend.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "backend.jar"]
