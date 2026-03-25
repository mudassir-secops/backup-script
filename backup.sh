#!/bin/bash

set -e

# step-01

source "$(dirname "$0")/.env"

# step-02

DATE=$(date +%Y-%m-%d_%H-%M-%S)
ARCHIVE_NAME="backup_$DATE.tar.gz"
LOG_FILE="$BACKUP_DIR/backup.log"
STATUS="SUCCESS"

# step-03

cleanup() {
	if [  $STATUS = "SUCCESS" ];
	then
		echo "$DATE SUCCESS - Backup created: $ARCHIVE_NAME" | tee -a "$LOG_FILE"
	        echo "-----------------------------------" >> "$LOG_FILE"
	
	else
 		echo "$DATE FAILED - Backup did not complete" | tee -a "$LOG_FILE"
		echo "-----------------------------------" >> "$LOG_FILE"

	fi
}


trap cleanup EXIT


# step-04

mkdir -p $BACKUP_DIR


# step-05

echo "$DATE Starting backup of : $SOURCE_DIR" | tee -a "$LOG_FILE"


# step-06

if [ ! -d "$SOURCE_DIR" ]; 
then
	echo "$DATE ERROR: Source folder not found : $SOURCE_DIR" | tee -a $LOG_FILE
	STATUS="FAILED"
	exit 1
fi


# step-07

tar -czf "$BACKUP_DIR/$ARCHIVE_NAME" $SOURCE_DIR


# step-08

echo "$DATE Deleting backups older than $RETENTION_DAYS days..." | tee -a "$LOG_FILE"

find "$BACKUP_DIR" -name "backup_*.tar.gz" -mtime +$RETENTION_DAYS -delete


# step-09

STATUS="SUCCESS"


