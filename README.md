## Container to use for automating docker-volume backups.

Just run this container with
1) docker-volumes mounted as readonly in /volumes/
2) Backup directory mounted in /backup
Now it will automatically backup docker volumes to the backup-directory daily @4:00am by default. You can change configuration options via environment variables see below. 

# Optional configuration changes via environment variables: 
```
TZ=Europe/London # default: UTC

CRON_BACKUP_PERIOD=0 4 * * * # by default every day @4:00 am. Check https://crontab.guru if you want to change this value.

BACKUP_LOG_RETENTION=30 # (number of logfiles, default 30)

BACKUP_DRYRUN=false # will run rsync in dryrun mode (no actual syncing). Use this for testing if everything is set up correctly. (default false)

UPTIME_PUSH_URL=https://uptime-kuma.iluvatyr.com/api/push/D4oIi3VXOj?status=up&msg=OK&ping= (default not set)
```

# Docker-compose
See docker-compose.yaml

# Docker run
## Without persistent log files (deleted when container is stopped)
```
docker run -it --rm --name volume-backup -v <your-volume-name-1>:/volumes/<your-volume-name-1>:ro <your-volume-name-x>:/volumes/<your-volume-name-x>:ro -v </your-backup-directory-bind-mount>:/backup -d iluvatyr/volume-backup:1.1
```
Optionally with persistent logfiles, mounted in /logs, where up to (default) 30 logfiles of each rsync backup are stored

## With persistent log files mounted in docker-volume
```
docker run -it --rm --name volume-backup -v <your-volume-name-1>:/volumes/<your-volume-name-1>:ro <your-volume-name-x>:/volumes/<your-volume-name-x>:ro -v </your-backup-directory-bind-mount>:/backup -v <logs-volume or /bind mount>:/var/log/volume-backup -d iluvatyr/volume-backup:1.1
```
