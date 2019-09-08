#!/bin/bash
LOG_DIR='/var/log/' 
LOG_FILE='del_old_images.log' 

if [ ! -f $LOG_DIR$LOG_FILE ]; 
	then touch $LOG_DIR$LOG_FILE; 
fi
echo Start delete 

#docker images | grep " [months|weeks]* ago" | awk '{print $3}' | xargs docker rmi
