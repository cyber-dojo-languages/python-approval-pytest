#!/usr/bin/env bash
set -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=`cat docker/image_name.json`
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
readonly APPROVALTESTS_EXPECTED="approvaltests-15.3.2"
readonly PYTEST_APPROVALS_EXPECTED="pytest-approvaltests-0.2.4"
# 'pytest --version --version' returns the plugins used by pytest - we can then use this
# to find the current versions of approvaltests and pytest-approvaltests
readonly PLUGINS=$((docker run --rm -i ${IMAGE_NAME} sh -c 'pytest --version --version') | grep 'approvaltests')

APPROVALTESTS_REGEX=" approvaltests-[0-9\.]*"
PYTEST_APPROVALS_REGEX="pytest-approvaltests-[0-9\.]*"
[[ ${PLUGINS} =~ ${APPROVALTESTS_REGEX} ]]
readonly APPROVALTESTS_ACTUAL="${BASH_REMATCH[*]}"
[[ ${PLUGINS} =~ ${PYTEST_APPROVALS_REGEX} ]]
readonly PYTEST_APPROVALS_ACTUAL="${BASH_REMATCH[*]}"

if echo "${APPROVALTESTS_ACTUAL}" | grep -q "${APPROVALTESTS_EXPECTED}"; then
  echo "VERSION CONFIRMED as ${APPROVALTESTS_EXPECTED}"
else
  echo "VERSION EXPECTED: ${APPROVALTESTS_EXPECTED}"
  echo "VERSION   ACTUAL: ${APPROVALTESTS_ACTUAL}"
  exit 42
fi

if echo "${PYTEST_APPROVALS_ACTUAL}" | grep -q "${PYTEST_APPROVALS_EXPECTED}"; then
  echo "VERSION CONFIRMED as ${PYTEST_APPROVALS_EXPECTED}"
else
  echo "VERSION EXPECTED: ${PYTEST_APPROVALS_EXPECTED}"
  echo "VERSION   ACTUAL: ${PYTEST_APPROVALS_ACTUAL}"
  exit 42
fi
