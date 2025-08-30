ARG IDF_IMAGE_TAG=

FROM espressif/idf:${IDF_IMAGE_TAG} AS sonar_ready

ARG SONAR_SCANNER_VERSION="7.2.0.5079"

ENV PATH="$PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux-x64/bin:/usr/bin/build-wrapper-linux-x86"

RUN curl --proto "=https" -sSLo /tmp/sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux-x64.zip" \
    && curl --proto "=https" -sSLo /tmp/build-wrapper-linux-x86.zip "https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip" \
    && unzip -o /tmp/sonar-scanner.zip -d /usr/bin \
    && unzip -o /tmp/build-wrapper-linux-x86.zip -d /usr/bin \
    && rm -rf /tmp/sonar-scanner.zip \
    && rm -rf /tmp/build-wrapper-linux-x86.zip

FROM sonar_ready

ENV BUILD_WRAPPER_OUTPUT_DIR="build_wrapper_output"

RUN mkdir /opt/sonar

COPY /scripts/entrypoint.sh /opt/sonar

ENTRYPOINT ["/opt/sonar/entrypoint.sh"]
CMD ["/bin/bash"]