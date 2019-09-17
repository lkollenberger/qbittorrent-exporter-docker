FROM openjdk:11.0.4-stretch
WORKDIR /build
COPY qbittorrent-exporter /build/
RUN /build/gradlew fatJar

FROM openjdk:11.0.4-jre-slim
ARG VERSION=2.0.0-dev
COPY --from=0 /build/build/libs/qbt-exporter-fat-$VERSION.jar /qbt-exporter.jar
ENTRYPOINT ["java", "-jar", "/qbt-exporter.jar"]
