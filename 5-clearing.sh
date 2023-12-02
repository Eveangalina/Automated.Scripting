#!/bin/bash

# Create a backup directory if it doesn't exist
backup_dir="/var/log/backups"
mkdir -p "$backup_dir"

# Get the current timestamp
timestamp=$(date +"%Y%m%d%H%M%S")

# Function to clear and compress logs
clear_compress_logs() {
    log_file=$1
    log_filename=$(basename "$log_file")

    # Print original log file size
    original_size=$(du -h "$log_file" | awk '{print $1}')
    echo "Original size of $log_filename: $original_size"

    # Compress log file to backup directory
    compressed_file="$backup_dir/${log_filename}-${timestamp}.zip"
    gzip -c "$log_file" > "$compressed_file"

    # Clear contents of the log file
    truncate -s 0 "$log_file"

    # Print compressed file size
    compressed_size=$(du -h "$compressed_file" | awk '{print $1}')
    echo "Compressed size of $compressed_file: $compressed_size"

    # Compare sizes
    echo "Comparison - Original vs Compressed:"
    echo "Original size: $original_size"
    echo "Compressed size: $compressed_size"
    echo ""
}

# Log files to clear and compress
log_files=(
    "/var/log/syslog"
    "/var/log/wtmp"
    # Add more log files here if needed
)

# Clear and compress specified log files
for file in "${log_files[@]}"; do
    clear_compress_logs "$file"
done
