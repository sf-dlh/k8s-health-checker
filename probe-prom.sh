#!/bin/bash

URL="https://google.com"
METRIC_DIR="/var/lib/prometheus/node-exporter/"

RESULT=$(curl -s -o /dev/null -L -I --connect-timeout 15 -w "%{response_code} %{time_total}" ${URL})

CODE=$(awk -F' ' '{print $1}' <<< "${RESULT}")
TIME=$(awk -F' ' '{print $2}' <<< "${RESULT}")



if [ "${CODE}" -eq 200 ];then
    STATUS=1
else STATUS=0
fi

{ cat <<-EOF
# HELP url_probe_success An HTTP status code of the URL provided; 1 if 200, 0 otherwise
# TYPE url_probe_success gauge
url_probe_success{url="${URL}"} ${STATUS}

# HELP url_time_to_connect Total time to connect to website
# TYPE url_time_to_connect gauge
url_time_to_connect{url="${URL}"} ${TIME}
EOF
} > ${METRIC_DIR}/health.prom.tmp

mv ${METRIC_DIR}/health.prom.tmp ${METRIC_DIR}/health.prom
