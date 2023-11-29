#!/bin/bash

# Get the current date and time
current_date=$(date +"%Y-%m-%d")
current_time=$(date +"%H:%M:%S")

# Construct the new filename with the current date and time
new_filename="syslog-${current_date}-${current_time}.log"

# Copy the syslog file to the current working directory with the updated filename
cp /var/log/syslog "$new_filename"

echo "Successfully copied syslog file to '$new_filename'."
