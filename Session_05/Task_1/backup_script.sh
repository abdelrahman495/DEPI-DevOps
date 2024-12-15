#!/bin/bash

# Specify source and destination directories
source_dir="/home/abdelrahman/"
export destination_dir="/home/abdelrahman/backup/"

# Specify remote user and remote host
export remote_user="abdelrahman"
export remote_host="host1"

# Create a backup directory on remote host if it doesn't already exist
ssh "$remote_user@$remote_host" "mkdir -p $destination_dir"

# Find source directory files that have been modified within the last day and transfer them using scp
find "$source_dir" -type f -mtime -1 -exec sh -c '
    scp "$0" "$remote_user@$remote_host:$destination_dir" && echo "$0 has been backed up"
' {} \;

