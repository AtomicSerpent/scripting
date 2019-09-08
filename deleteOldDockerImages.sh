#!/bin/bash
LOG_DIR='/var/log/'
LOG_FILE='del_old_images.log'
PARAM=$1
DATE_TIME=$(date +%Y-%m-%d-%H-%M)
IMAGE_LIST= "docker images | awk '{print $3,$4,$5}'"


function write_log {
	echo -e "$DATE_TIME\n$1\n" |tee -a $LOG_DIR$LOG_FILE
}


function delete {
write_log 'Getting list '$IMAGE_LIST
}

if [ ! -f $LOG_DIR$LOG_FILE ];
	then
	echo Creating log file
	echo..............
	touch $LOG_DIR$LOG_FILE;
	echo Done!
fi

write_log 1234

write_log 123
#docker images | grep " [months|weeks]* ago" | awk '{print $3}' | xargs docker rmi
