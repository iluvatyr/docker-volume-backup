#!/bin/sh

## Colors
green="\e[0;92m"
purple="\e[0;35m"
reset="\e[0m"

#echo "${green}"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "$(date)"
echo "Starting backup process docker volumes"
echo "Running following command:"
echo "rsync -avri --delete /volumes/ /backup/"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
#echo "${reset}"

## Actual code
logname="$(date +"%Y-%m-%d-%H-%M")-volume-backup.txt"
begin=$(date +%s) #Starttime rsync
rsync -avri --delete /volumes/ /backup/ | tee "/logs/$logname"
end=$(date +%s) #Endtime rsync
tottime=$(expr $end - $begin)
retention=30 ## Keep the last 30 logfiles
find /logs/*.txt -maxdepth 1 -type f | sort -n | head -n -$retention | xargs rm -f --

#echo "${purple}"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "$(date)"
echo "Backing up docker volumes finished in $tottime seconds"
echo "Log retention set to $retention, deleting oldest"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
echo "--------------------------------------------------------"
#echo "${reset}"
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
echo "."
