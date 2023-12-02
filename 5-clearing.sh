#!/bin/bash

backup_dir="/var/log/backups"
timestamp=$(date +"%Y%m%d%H%M%S")

clear_compress_logs() {
    log_file=$1
    log_filename=$(basename "$log_file")

    original_size=$(du -h "$log_file" | awk '{print $1}')
    echo "Original size of $log_filename: $original_size"

    compressed_file="$backup_dir/${log_filename}-${timestamp}.zip"
    gzip -c "$log_file" > "$compressed_file"

    truncate -s 0 "$log_file"

    compressed_size=$(du -h "$compressed_file" | awk '{print $1}')
    echo "Compressed size of $compressed_file: $compressed_size"

    echo "Comparison - Original vs Compressed:"
    echo "Original size: $original_size"
    echo "Compressed size: $compressed_size"
    echo ""
}

log_files=(
    "/var/log/syslog"
    "/var/log/wtmp"
)

for file in "${log_files[@]}"; do
    clear_compress_logs "$file"
done
