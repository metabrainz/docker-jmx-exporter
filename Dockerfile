# Some definitions for base image
FROM eclipse-temurin:21.0.9_10-jdk-alpine-3.22@sha256:c4799f335a65b1ecca8a31239b05522f2b0a184d6818f6349e83484ee6956198
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
