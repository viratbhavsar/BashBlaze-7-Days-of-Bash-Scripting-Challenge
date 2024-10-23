#!/bin/bash

# Check if a log file path is provided
if [ $# -eq 0 ]; then
    echo "Error: Please provide the path to the log file as an argument."
    echo "Usage: $0 <path_to_log_file>"
    exit 1
fi

# Input log file
log_file="$1"

# Check if the log file exists
if [ ! -f "$log_file" ]; then
    echo "Error: The specified log file does not exist."
    exit 1
fi

# Output report file
report_file="log_analysis_report_$(date +%Y%m%d_%H%M%S).txt"

# Function to count errors
function count_errors() {
    grep -c "ERROR" "$log_file"
}

# Function to find critical events
function find_critical_events() {
    grep -n "CRITICAL" "$log_file"
}

# Function to get top 5 error messages
function get_top_errors() {
    grep "ERROR" "$log_file" | awk -F "ERROR" '{print $2}' | sort | uniq -c | sort -nr | head -n 5
}

# Generate the report
echo "Log Analysis Report" > "$report_file"
echo "Date: $(date)" >> "$report_file"
echo "Log File: $log_file" >> "$report_file"
echo "Total Lines Processed: $(wc -l < "$log_file")" >> "$report_file"
echo "Total Error Count: $(count_errors)" >> "$report_file"
echo "" >> "$report_file"

echo "Top 5 Error Messages:" >> "$report_file"
get_top_errors >> "$report_file"
echo "" >> "$report_file"

echo "Critical Events:" >> "$report_file"
find_critical_events >> "$report_file"

echo "Report generated: $report_file"

# Optional: Archive the log file
archive_dir="processed_logs"
if [ ! -d "$archive_dir" ]; then
    mkdir "$archive_dir"
fi
mv "$log_file" "$archive_dir/"
echo "Log file moved to $archive_dir/"