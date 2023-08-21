#!/usr/bin/env bash
set -e

. $IDF_PATH/export.sh

if [ $2 == "build" ]
then
  if [ -z "$SONARCLOUD_ORGANIZATION" ]
  then
    echo "info: building without Sonar Cloud analysis"

    "$@"
  else
    echo "info: building with Sonar Cloud analysis"

    build-wrapper-linux-x86-64 --out-dir $BUILD_WRAPPER_OUTPUT_DIR $@

    if [ $? -eq 0 ]
    then
      sonar-scanner --define sonar.host.url="https://sonarcloud.io" \
        --define sonar.organization=$SONARCLOUD_ORGANIZATION \
        --define sonar.token=$SONARCLOUD_TOKEN

      if [ $? -eq 0 ]
      then
        exit 0
      else
        echo "failure: sonar-scanner"
        exit 1
      fi
    else
      echo "failure: idf.py build"
      exit 1
    fi
  fi
else
  echo "info: executing non build command '$2'"

  "$@"
fi
