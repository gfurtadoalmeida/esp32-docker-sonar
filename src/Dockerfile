ARG IDF_IMAGE_TAG=

FROM espressif/idf:${IDF_IMAGE_TAG} AS sonar_ready

ARG SONAR_SCANNER_VERSION="8.1.0.6389"

ENV PATH="$PATH:/usr/bin/sonar-scanner-$SONAR_SCANNER_VERSION-linux-x64/bin:/usr/bin/build-wrapper-linux-x86"

RUN curl --proto "=https" -sSLo /tmp/sonar-scanner.zip "https://binaries.sonarsource.com/Distribution/sonar-scanner-cli/sonar-scanner-cli-$SONAR_SCANNER_VERSION-linux-x64.zip" \
    && curl --proto "=https" -sSLo /tmp/build-wrapper-linux-x86.zip "https://sonarcloud.io/static/cpp/build-wrapper-linux-x86.zip" \
    && unzip -o /tmp/sonar-scanner.zip -d /usr/bin \
    && unzip -o /tmp/build-wrapper-linux-x86.zip -d /usr/bin \
    && rm -rf /tmp/sonar-scanner.zip \
    && rm -rf /tmp/build-wrapper-linux-x86.zip

FROM sonar_ready

# Component manager 2.0-2.2 fails on dependencies with Kconfig conditions
# when sdkconfig doesn't exist yet (fresh builds). Fixed in 2.3; other
# versions are left as installed to respect each IDF version constraints.
RUN bash -c '. "$IDF_PATH/export.sh" >/dev/null \
    && CM_VERSION=$(python -m pip show idf-component-manager 2>/dev/null | sed -n "s/^Version: //p") \
    && case "$CM_VERSION" in \
         2.0.*|2.1.*|2.2.*) python -m pip install --upgrade "idf-component-manager>=2.3,<3" ;; \
         *) echo "idf-component-manager ${CM_VERSION:-not installed}: no upgrade needed" ;; \
       esac'

ENV BUILD_WRAPPER_OUTPUT_DIR="build_wrapper_output"

RUN mkdir /opt/sonar

COPY /scripts/entrypoint.sh /opt/sonar

ENTRYPOINT ["/opt/sonar/entrypoint.sh"]
CMD ["/bin/bash"]