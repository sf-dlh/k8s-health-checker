#!/bin/bash
CODE=$(curl -s -o /dev/null -L -I --connect-timeout 15 -w "%{response_code}" https://google.com)

THIS_DIR=$(cd "$(dirname "$0")" && pwd)


if [ "${CODE}" -eq 200 ]; then
    STATUS="UP"
else STATUS="DOWN"
fi

echo "$(date +"%Y-%m-%d %H:%M:%S") | https://google.com | ${CODE} | ${STATUS}" >> ${THIS_DIR}/health.log

