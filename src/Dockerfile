ARG IDF_IMAGE_TAG=

FROM espressif/idf:${IDF_IMAGE_TAG} AS base

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get -qq update \
    && apt-get install -y -q --no-install-recommends openjdk-17-jre \
    && rm -rf /var/lib/apt/lists/*

FROM base AS sonar_ready

ARG SONAR_SCANNER_VERSION=

ENV PATH="$PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux/bin:/usr/bin/build-wrapper-linux-x86"

RUN curl -sSLo /tmp/sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux.zip" \
    && curl -sSLo /tmp/build-wrapper-linux-x86.zip "https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip" \
    && unzip -o /tmp/sonar-scanner.zip -d /usr/bin \
    && unzip -o /tmp/build-wrapper-linux-x86.zip -d /usr/bin \
    && rm -rf /tmp/sonar-scanner.zip \
    && rm -rf /tmp/build-wrapper-linux-x86.zip

FROM sonar_ready

ENV BUILD_WRAPPER_OUTPUT_DIR="build_wrapper_output"
ENV SONARCLOUD_ORGANIZATION=""
ENV SONARCLOUD_TOKEN=""

RUN mkdir /opt/sonar \
    && groupadd --gid 1988 builder \
    && adduser --uid 1802 --gid 1988 --disabled-password --gecos "" idf

COPY /scripts/entrypoint.sh /opt/sonar

USER idf

ENTRYPOINT ["/opt/sonar/entrypoint.sh"]
CMD ["/bin/bash"]