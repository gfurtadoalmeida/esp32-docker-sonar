#!/usr/bin/env bash
set -e

. "$IDF_PATH/export.sh"

if [ "$2" == "build" ];  then
  if [[ -z "$EDS_ORG" || -z "$EDS_TOKEN" ]]; then
    echo "info: building without Sonar Cloud analysis"

    "$@"
  else
    echo "info: building with Sonar Cloud analysis"

    build-wrapper-linux-x86-64 --out-dir "$BUILD_WRAPPER_OUTPUT_DIR" "$@"

    if [ $? -eq 0 ]; then
      cmd="sonar-scanner --define sonar.host.url=https://sonarcloud.io \
            --define sonar.organization=$EDS_ORG \
            --define sonar.token=$EDS_TOKEN"

      [ -n "$EDS_BRANCH" ] && cmd+=" --define sonar.branch.name=$EDS_BRANCH"

      [ -n "$EDS_PR_KEY" ] && cmd+=" --define sonar.pullrequest.key=$EDS_PR_KEY"

      [ -n "$EDS_PR_BRANCH" ] && cmd+=" --define sonar.pullrequest.branch=$EDS_PR_BRANCH"

      [ -n "$EDS_PR_BASE" ] && cmd+=" --define sonar.pullrequest.base=$EDS_PR_BASE"

      eval "$cmd"

      if [ $? -eq 0 ]; then
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
