#!/bin/bash
LOG_DIR='/var/log/'
LOG_FILE='del_old_images.log'
PARAM_DELETE=$1
DATE_TIME=$(date +%Y-%m-%d-%H-%M)
IMAGE_LIST= docker images | awk '{print $2,$3,$4,$5}'


function write_log {
	echo -e "\n$DATE_TIME\n$1\n" |tee -a $LOG_DIR$LOG_FILE
}


function delete {
	write_log 'Getting_list'
	docker images | tee -a $LOG_DIR$LOG_FILE

}



if [ ! -f $LOG_DIR$LOG_FILE ];
	then
	echo Creating log file
	echo ..............
	touch $LOG_DIR$LOG_FILE;
	echo Done!
fi

delete



#docker images | grep " [months|weeks]* ago" | awk '{print $3}' | xargs docker rmi
