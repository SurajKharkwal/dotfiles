#!/bin/bash

FOLDER=""
read -p "Enter the folder name: " FOLDER

MOUNT_POINT=~/clg-server
SMB_SHARE="//172.16.73.6/$FOLDER"
USERNAME="231030071"
DOMAIN="juitw"

# Ensure the mount point exists
mkdir -p "$MOUNT_POINT"

# Check if already mounted and unmount if necessary
if mount | grep -q "$MOUNT_POINT"; then
    echo "Unmounting previous mount..."
    sudo umount "$MOUNT_POINT"
fi

# Mount the SMB share
sudo mount -t cifs "$SMB_SHARE" "$MOUNT_POINT" -o username="$USERNAME",domain="$DOMAIN"
if [[ $? -ne 0 ]]; then
    echo "Failed to mount SMB share."
    exit 1
fi

# Ensure unmounting when the script exits
trap 'sudo umount "$MOUNT_POINT" && rm -rf "$MOUNT_POINT"' EXIT

# Open in Yazi
(yazi "$MOUNT_POINT")
