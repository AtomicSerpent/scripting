#!/bin/bash
LOG_DIR='/var/log/'
LOG_FILE='del_old_images.log'
PARAM_DELETE=$1
DATE_TIME=$(date +%Y-%m-%d-%H-%M)
#IMAGE_LIST= docker images | awk '{print $2,$3,$4,$5}'


function write_log {
	echo -e "\n$DATE_TIME\n$1\n" |tee -a $LOG_DIR$LOG_FILE
}


function delete {
	write_log Getting list
	docker images | tee -a $LOG_DIR$LOG_FILE

	echo Next images will be delete

	if [ $1 != "all"];then
		list=$(docker images | grep " [$PARAM_DELETE]* ago" | awk '{print $3}')
	else
		list=$(docker images | awk '{print $3}')
	fi

	for value in $list
		do
		echo Deleting $value | tee -a $LOG_DIR$LOG_FILE
		#docker rmi $value
	done
}

echo -e "\e[1;33mEnter parameter <help> to see help\e[0m" 
#Checking for log file
if [ ! -f $LOG_DIR$LOG_FILE ];then
	echo Creating log file
	echo ..............
	touch $LOG_DIR$LOG_FILE;
	echo Done!
fi

#Checking if parameter present
if [ -z $PARAM_DELETE ]; then
	write_log "Enter Parameter Please"
	exit 1
fi 

#Checking parameters
if [ $PARAM_DELETE == "weeks" ] || [ $PARAM_DELETE == "months" ] ;then
	delete $PARAM_DELETE

elif [ $PARAM_DELETE == "mv" ];then
	delete "[months|weeks]"

elif [ $PARAM_DELETE == "all" ];then
	write_log "ALL images will be deleted"
	delete $PARAM_DELETE

elif [ $PARAM_DELETE == "help" ];then
	echo -e  "\e[1;33mUse <weeks> to delete image weeks of antiquity\e[0m"
	echo -e  "\e[1;33mUse <months> to delete month image of antiquity\e[0m"
	echo -e  "\e[1;33mUse <mw> to delete month and weeks of antiquity\e[0m"
	echo -e  "\e[1;33mUse the range <1..100> to store first N images \e[0m"
	echo -e  "\e[1;33mUse <all> to delete all images\e[0m"
else
	echo -e  "\e[1;31mWrong Parameter $PARAM_DELETE\e[0m" 
fi

#echo $PARAM_DELETE
#docker images | grep " [months|weeks]* ago" | awk '{print $3}' | xargs docker rmi
