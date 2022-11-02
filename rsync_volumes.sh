#!/bin/sh

logdir="/var/log/volume-backup"
logname="$(date +"%Y-%m-%d-%H-%M")-volume-backup.txt"
begin=$(date +%s) #Starttime rsync

backup_function(){
	if [ -f /app/.dryrun ]
	then
		rsync -avri -n --delete /volumes/ /backup/ | tee "$logdir/$logname"
	else
		rsync -avri --delete /volumes/ /backup/ | tee "$logdir/$logname"
	fi
}

echo -e "${green}"
echo -e "--------------------------------------------------------"
echo -e "$(date)"
echo -e "Start backup of docker volumes"
echo -e "--------------------------------------------------------"
echo -e "${reset}"

if ( backup_function )
then
	## Calculating rsync time
	end=$(date +%s) #Endtime rsync
	tottime=$(expr $end - $begin)
	echo -e "${green}"
	echo -e "--------------------------------------------------------"
	echo -e "$(date)"
	echo -e "Successfully finished backup of docker volumes."
	echo -e "Duration: $tottime seconds"
	/app/delete_old_logs.sh
	echo -e "${green}--------------------------------------------------------"
        echo -e "${reset}"
	## HEAD-Request to URL for monitoring if script ran successfully
	/app/uptime_push.sh
	/app/delete_old_logs.sh
else
	echo -e "Error: Backup was not fully successful. Check the $logdir/$logname for more info."
fi
