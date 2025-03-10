FROM adoptopenjdk:17-jdk
WORKDIR /app
COPY target/board-1.0-SNAPSHOT.war board.war
CMD ["java", "-jar", "board.war"]
