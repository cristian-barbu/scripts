#!/bin/bash

# Usage: $0 [SOURCE|TARGET] folder_name
validate_dir () {
    if [ ! -d "$2" ]; then
        echo "The peovided $1 directory is not valid.";
	exit 2;
    fi
}

#In the context of this script, "back up" means to move the old unused files away
#to a "back up" folder; This is ment to be used with a cron, to continuously 
#remove the clutter. 

DATA_SOURCE_DIR=""; #All files, and folders in this will be backed up. 
DATA_TARGET_ROOT="/media/cristian13/Data1"; #TODO: Get from config | env
DATA_TARGET_DIR="";
DELETE_DATA_FLAG=0;

if [ $# -lt 1 ]; then
    echo "Usage: $0 source_dir [delete_backed_up_data_flag] [target_dir]";
    exit 1;
fi

# Get backup source
DATA_SOURCE_DIR=$1;
validate_dir SOURCE "$DATA_SOURCE_DIR"

if [ $# -ge 2 ]; then
    if [ $2 == "DELETE" ]; then
        DELETE_DATA_FLAG=1;
    fi

    #TODO: Handle other argouments
fi

IS_MOUNTED=`df | cut -d' ' -f1 | grep "/dev/sda1" -c`;
if [ ! "$IS_MOUNTED" -eq 1 ]; then
    echo "Backup drive not mounted.";
    exit 3;
fi


#TODO: Figure out why I can't copy without sudo;
#TODO: Use a variable for the copy/move command; and remove the FLAG
echo "Copying files";

sudo cp -r "$DATA_SOURCE_DIR" "$DATA_TARGET_ROOT/$DATA_SOURCE_DIR"
echo "Done";

# Copy all files/folders older than x days.

# ++add safety check to make sure same count of items coppied as will be deleted;
# Delete all files/folders older than x days.


