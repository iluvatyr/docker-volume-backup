## Container to use for automating docker-volume backups.

Just run this container with
1) docker-volumes mounted as readonly in /volumes/
2) Backup directory mounted in /backup
3) Now it will automatically backup docker volumes to the backup-directory every day @4:00 

## Without persistent log files (deleted when container is stopped)
docker run -it --rm --name volume-backup -v <your-volume-name-1>:/volumes/<your-volume-name-1>:ro <your-volume-name-x>:/volumes/<your-volume-name-x>:ro -v </your-backup-directory-bind-mount>:/backup -d iluvatyr/volume-backup:latest

Optionally with persistent logfiles, mounted in /logs, where up to (default) 30 logfiles of each rsync backup are stored

## With persistent log files
docker run -it --rm --name volume-backup -v <your-volume-name-1>:/volumes/<your-volume-name-1>:ro <your-volume-name-x>:/volumes/<your-volume-name-x>:ro -v </your-backup-directory-bind-mount>:/backup -v <logs-volume or /bind mount>:/logs -d iluvatyr/volume-backup:latest

## Optional configuration changes: 
1) Change timezone in Dockerfile
2) Change retention value for logs in rsync-volumes.sh (default 30)


