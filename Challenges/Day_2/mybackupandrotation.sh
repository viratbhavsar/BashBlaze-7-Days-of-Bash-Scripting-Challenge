#!/bin/bash

# Function to display usage information
function usage {
    echo "Usage: $0 <directory_path>"
    exit 1
}

# Function to check if directory exists
function check_directory {
    if [ ! -d "$1" ]; then
        echo "Error: Directory does not exist."
        exit 1
    fi
}

# Function to create backup using zip
function create_backup {
    local dir_path="$1"
    local timestamp=$(date +"%Y-%m-%d_%H-%M-%S")
    local backup_file="${dir_path}/backup_${timestamp}.zip"

    if ! command -v zip &> /dev/null; then
        echo "Error: zip command not found. Please install zip."
        exit 1
    fi

    zip -r "$backup_file" "$dir_path" -x "$dir_path/backup_*"
    if [ $? -eq 0 ]; then
        echo "Backup created: $backup_file"
    else
        echo "Error: Backup creation failed."
        exit 1
    fi
}

# Function to rotate backups using array
function rotate_backups {
    local dir_path="$1"
    local backups=($(ls -t "${dir_path}"/backup_*.zip 2>/dev/null))

    if [ "${#backups[@]}" -gt 3 ]; then
        echo "Rotating backups. Keeping only the 3 most recent."
        local backups_to_remove=("${backups[@]:3}")
        for backup in "${backups_to_remove[@]}"; do
            rm -f "$backup"
            echo "Removed old backup: $backup"
        done
    else
        echo "No backup rotation needed. Current backup count: ${#backups[@]}"
    fi
}

# Main script execution
function main {
    # Check if a directory path is provided
    [ $# -eq 0 ] && usage

    local dir_path="$1"

    check_directory "$dir_path"
    create_backup "$dir_path"
    rotate_backups "$dir_path"
}

# Run the main function
main "$@"
