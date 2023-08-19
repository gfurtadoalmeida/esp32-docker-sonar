ARG IDF_IMAGE_TAG=

FROM espressif/idf:${IDF_IMAGE_TAG} AS base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update \
    && apt-get install --no-install-recommends --yes openjdk-17-jre

FROM base AS sonar_ready

ARG SONAR_SCANNER_VERSION=

ENV PATH="$PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin:/usr/bin/build-wrapper-linux-x86"

RUN curl -sSLo /tmp/sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip" \
    && curl -sSLo /tmp/build-wrapper-linux-x86.zip "https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip" \
    && unzip -o /tmp/sonar-scanner.zip -d /usr/bin \
    && unzip -o /tmp/build-wrapper-linux-x86.zip -d /usr/bin \
    && rm /tmp/sonar-scanner.zip \
    && rm /tmp/build-wrapper-linux-x86.zip

FROM sonar_ready

ENV RUN_SONAR="1"
ENV SONAR_WRAPPER_OUTPUT_DIR="build_wrapper_output"
ENV SONAR_ORGANIZATION_NAME=""
ENV SONAR_ORGANIZATION_TOKEN=""

COPY /scripts/build.sh /usr/bin

CMD ["/bin/bash", "build.sh"]