# Some definitions for base image
FROM eclipse-temurin:21.0.10_7-jdk-alpine-3.22@sha256:e5138ee5faa9ef7cdbd5503b9147e618ba8c8301a88bef40ea6dc426ac7cfe63
ENV JAVA_HOME=/opt/java/openjdk
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# renovate: datasource=github-release-attachments depName=jmx_exporter packageName=prometheus/jmx_exporter
ENV JMX_EXPORTER_VERSION="1.5.0"
ENV JMX_EXPORTER_CHECKSUM="bf4e061dca52169764c484d5931a8513798070db75cd2b6ba8303d20cb2530f1"
ENV JAR_URL="https://github.com/prometheus/jmx_exporter/releases/download/${JMX_EXPORTER_VERSION}/jmx_prometheus_standalone-${JMX_EXPORTER_VERSION}.jar"

# App deployment
RUN  addgroup -S appuser && adduser -S appuser -G appuser --disabled-password
RUN mkdir /opt/app && chown appuser /opt/app

USER appuser
WORKDIR /opt/app

RUN <<EOF
  set -eux
  wget -O jmx_prometheus_standalone.jar $JAR_URL
  echo "$JAR_CHECKSUM  jmx_prometheus_standalone.jar" | sha256sum -c -
EOF

RUN chown appuser:appuser jmx_prometheus_standalone.jar
EXPOSE 5556
USER appuser
ENTRYPOINT [ "java", "-jar", "jmx_prometheus_standalone.jar" ]
CMD ["5556", "jmx-exporter.yml"]
