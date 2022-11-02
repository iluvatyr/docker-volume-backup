#!/bin/sh -e

set -a
## Setting default values for environment variables
export TZ="${TZ:-Universal}" ## default to UTC
UPTIME_PUSH_URL="${UPTIME_PUSH_URL:-}" ## default to not set
BACKUP_LOG_RETENTION="${BACKUP_LOG_RETENTION:-30}" ## default:30
CRON_BACKUP_PERIOD="${CRON_BACKUP_PERIOD:-"0 4 * * *"}" ## default to daily @4:00 am
BACKUP_DRYRUN="${BACKUP_DRYRUN:-false}"

echo "$UPTIME_PUSH_URL" > /app/.uptime_push_url ##uptime_push.sh reads this
echo "$BACKUP_LOG_RETENTION" > /app/.backup_log_retention ##delete_old_logs.sh reads this

## rsync-volume.sh checks if /app/.dryrun exists and then runs as dryrun
if ( "${BACKUP_DRYRUN}" ); then touch /app/.dryrun; fi 

## Setting up colors for echo, exporting so all scripts can use it
export green="\e[0;92m"
export reset="\e[0m"

beautify_cronjob(){
echo -e "Backup runs as followed (read * as every)"
echo "####################"
echo -e -n "# minute:\t "; echo "$1" | awk -F " " '{print $1" #"}'
echo -e -n "# hour:\t\t "; echo "$1" | awk -F " " '{print $2" #"}'
echo -e -n "# day (month):\t "; echo "$1" | awk -F " " '{print $3" #"}'
echo -e -n "# month:\t "; echo "$1" | awk -F " " '{print $4" #"}'
echo -e -n "# day (week):\t "; echo "$1" | awk -F " " '{print $5" #"}'
echo "####################"
}

## Add cronjob with time set in environment variables
echo "${CRON_BACKUP_PERIOD} /app/rsync_volumes.sh" > /etc/crontabs/root


echo -e "${green}Volume-backup started successfully${reset}"
beautify_cronjob "$CRON_BACKUP_PERIOD"

## Start cron which runs the backup script periodically
exec crond -f -l 8 "$@"
