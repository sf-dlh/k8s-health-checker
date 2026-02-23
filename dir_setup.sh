#!/bin/bash

DIR=$(cd "$(dirname "$0")" && pwd)

sed "s:PROJECT_DIR:${DIR}" crontab.template > cron_probe

crontab cron_probe

rm cron_probe