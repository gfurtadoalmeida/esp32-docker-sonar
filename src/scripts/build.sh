#!/bin/bash

if [ $RUN_SONAR == "0" ]
then
  echo "info: building without Sonar Cloud analysis"

  idf.py build

  exit $?
else
  echo "info: building with Sonar Cloud analysis"

  build-wrapper-linux-x86-64 --out-dir $SONAR_WRAPPER_OUTPUT_DIR idf.py build

  if [ $? -eq 0 ]
  then
    sonar-scanner --define sonar.host.url="https://sonarcloud.io" \
      --define sonar.organization=$SONAR_ORGANIZATION_NAME \
      --define sonar.token=$SONAR_ORGANIZATION_TOKEN

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