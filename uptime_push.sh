#!/bin/sh

UPTIME_PUSH_URL=$(cat /app/.uptime_push_url)

## Run if UPTIME_PUSH_URL is set
if [ -n "${UPTIME_PUSH_URL}" ]
then
	info=$(curl -s --connect-timeout 1 --max-time 2 -I "${UPTIME_PUSH_URL}")
fi
