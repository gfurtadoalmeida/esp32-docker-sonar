#!/usr/bin/env bats

SCRIPT="./src/scripts/entrypoint.sh"

setup() {
    ORIGINAL_PATH=$PATH

    export PATH="/code/test/mocks/sonar:/code/test/mocks/esp-idf:$PATH"
    export IDF_PATH="/code/test/mocks/esp-idf"
    export EDS_ORG="my_org"
    export EDS_TOKEN="123"

    bats_load_library bats-assert
}

teardown() {
    export PATH=$ORIGINAL_PATH
}

#
# Non build.
#

@test "When command is not build then run without analysis" {
    run bash "$SCRIPT" "idf_py.sh" "clear"

    assert_success
    assert_line --partial 'non build'
}

#
# No analysis.
#

@test "When env EDS_TOKEN is not set and EDS_ORG is set then run without analysis" {
    export EDS_TOKEN=""

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial 'without'
}

@test "When env EDS_TOKEN is set and EDS_ORG is not set then run without analysis" {
    export EDS_ORG=""

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial 'without'
}

#
# Parameters check.
#

@test "When env EDS_ORG is set then add argument to sonar" {
    export EDS_ORG="my_org"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.organization=$EDS_ORG"
}

@test "When env EDS_TOKEN is set then add argument to sonar" {
    export EDS_TOKEN="123"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.token=$EDS_TOKEN"
}

@test "When env EDS_BRANCH is set then add argument to sonar" {
    export EDS_BRANCH="master"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.branch.name=$EDS_BRANCH"
}

@test "When env EDS_PR_KEY is set then add argument to sonar" {
    export EDS_PR_KEY="123"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.pullrequest.key=$EDS_PR_KEY"
}

@test "When env EDS_PR_BRANCH is set then add argument to sonar" {
    export EDS_PR_BRANCH="feature/feature-123"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.pullrequest.branch=$EDS_PR_BRANCH"
}

@test "When env EDS_PR_BASE is set then add argument to sonar" {
    export EDS_PR_BASE="master"

    run bash "$SCRIPT" "idf_py.sh" "build"

    assert_success
    assert_line --partial "--define sonar.pullrequest.base=$EDS_PR_BASE"
}
