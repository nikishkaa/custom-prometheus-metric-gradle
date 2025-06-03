FROM gradle:7.6.1-jdk8 AS build
WORKDIR /app
COPY . .
RUN gradle bootJar -x test --no-daemon --stacktrace --info

FROM openjdk:8-jre-slim
WORKDIR /app
COPY --from=build /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"] 