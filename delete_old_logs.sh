#!/bin/sh

BACKUP_LOG_RETENTION=$(cat /app/.backup_log_retention)
logdir="/var/log/volume-backup"

if [ $(ls /var/log/volume-backup | wc -l) -gt $BACKUP_LOG_RETENTION ]; then
	echo -e "${green}Log cleanup: keep last $BACKUP_LOG_RETENTION logfiles. Removing:${reset}"
	find "$logdir"/*.txt -maxdepth 1 -type f | sort -n | head -n -$BACKUP_LOG_RETENTION
	find "$logdir"/*.txt -maxdepth 1 -type f | sort -n | head -n -$BACKUP_LOG_RETENTION | xargs rm -f --
fi
