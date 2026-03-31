#!/usr/bin/env bash
set -Eeu

readonly REGEX="image_name\": \"(.*)\""
readonly JSON=`cat docker/image_name.json`
[[ ${JSON} =~ ${REGEX} ]]
readonly IMAGE_NAME="${BASH_REMATCH[1]}"

readonly MY_DIR="$( cd "$( dirname "${0}" )" && pwd )"
readonly PYTEST_APPROVALS_EXPECTED="pytest-approvaltests-0.2.4"
readonly PLUGINS=$(docker run --rm -i ${IMAGE_NAME} sh -c 'pytest --version --version' | grep 'approvaltests')

PYTEST_APPROVALS_REGEX="pytest-approvaltests-[0-9\.]*"
[[ ${PLUGINS} =~ ${PYTEST_APPROVALS_REGEX} ]]
readonly PYTEST_APPROVALS_ACTUAL="${BASH_REMATCH[*]}"

if echo "${PYTEST_APPROVALS_ACTUAL}" | grep -q "${PYTEST_APPROVALS_EXPECTED}"; then
  echo "VERSION CONFIRMED as ${PYTEST_APPROVALS_EXPECTED}"
else
  echo "VERSION EXPECTED: ${PYTEST_APPROVALS_EXPECTED}"
  echo "VERSION   ACTUAL: ${PYTEST_APPROVALS_ACTUAL}"
  exit 42
fi
