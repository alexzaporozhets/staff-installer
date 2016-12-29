#!/bin/sh
set -x
export AZURE_STORAGE_ACCESS_KEY=${AZURE_STORAGE_KEY}
export AZURE_STORAGE_ACCOUNT=${AZURE_STORAGE_NAME}
azure storage share create backup -a ${AZURE_STORAGE_NAME} -k ${AZURE_STORAGE_KEY}
