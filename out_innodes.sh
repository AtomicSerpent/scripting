#!/bin/bash
############################################
####Start every Wednesday and Sunday########
############################################
LOG_DIR='/var/log/'
LOG_FILE='innodes_del.log'
DATE_TIME=$(date +%Y-%m-%d-%H-%M)

if [ ! -f $LOG_DIR$LOG_FILE ];then
	echo Creating log file
	echo ..............
	touch $LOG_DIR$LOG_FILE;
	echo Done!
fi
###################################################################
#### if you are migrating a server  or reconfiguring hard drives,##
#### check this option |sed -n '4p'| ##############################
###################################################################


innode = $(df -hi | sed -n '4p' | awk '{print $5}' | grep -v U | cut -d% -f1)

if (($innode > 70)); then
  	echo -e "\n$DATE_TIME\nStoping Docker Services\n" |tee -a $LOG_DIR$LOG_FILE
      service docker stop
    echo -e "\n$DATE_TIME\nDelete /var/lib/docker\n" |tee -a $LOG_DIR$LOG_FILE
      rm -rf /var/lib/docker
    echo -e "\n$DATE_TIME\nDone!\n" |tee -a $LOG_DIR$LOG_FILE
      service docker stop
    echo -e "\n$DATE_TIME\n!!!!Docker Service started!!!!!\n" |tee -a $LOG_DIR$LOG_FILE
fi
