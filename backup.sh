#!/usr/bin/env bash

############################################
# backup.sh - Completed for all 17 Tasks
############################################

############################################
# [TASK 1] Set variables
############################################
targetDirectory="$HOME/mydata"
destinationDirectory="$HOME/backups"

############################################
# [TASK 2] Display values to user
############################################
echo "Target directory: $targetDirectory"
echo "Destination directory: $destinationDirectory"

############################################
# [TASK 3] Set current timestamp (seconds)
############################################
currentTS=$(date +%s)

############################################
# [TASK 4] Set backup file name
############################################
backupFileName="backup-${currentTS}.tar.gz"

############################################
# [TASK 5] Define origAbsPath
############################################
origAbsPath=$(realpath "$targetDirectory")

############################################
# [TASK 6] Define destAbsPath
############################################
destAbsPath=$(realpath "$destinationDirectory")

############################################
# [TASK 7] Change directory to targetDirectory
############################################
cd "$targetDirectory"

############################################
# [TASK 8] Yesterday timestamp (seconds)
############################################
yesterdayTS=$(( currentTS - 86400 ))

############################################
# [TASK 9] List all files and directories
############################################
allFiles=$(ls -A)

############################################
# [TASK 10] IF to check updated files
############################################
toBackup=()
for file in $allFiles; do
    fileTS=$(date -r "$file" +%s)
    if [ "$fileTS" -ge "$yesterdayTS" ]; then

############################################
# [TASK 11] Add updated files to array
############################################
        toBackup+=("$file")
    fi
done

############################################
# [TASK 12] Create backup archive
############################################
tar -czf "$backupFileName" "${toBackup[@]}"

############################################
# [TASK 13] Move backup to destination
############################################
mv "$backupFileName" "$destAbsPath"

echo "Backup complete: ${destAbsPath}/${backupFileName}"
