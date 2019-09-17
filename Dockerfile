FROM openjdk:11.0.4-stretch
WORKDIR /build
COPY qbittorrent-exporter /build/
RUN /build/gradlew fatJar

FROM openjdk:11.0.4-jre-slim
ARG VERSION=2.0.0-dev
COPY --from=0 /build/build/libs/qbt-exporter-fat-$VERSION.jar /qbt-exporter.jar
ENV JAVA_OPTS="-Xmx64m -Xms64m"
ENTRYPOINT ["/bin/sh", "-c", "java $JAVA_OPTS -jar /qbt-exporter.jar"]
