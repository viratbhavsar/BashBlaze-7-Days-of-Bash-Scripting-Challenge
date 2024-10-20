#!/bin/bash

# Function to perform recursive search
recursive_search() {
    local current_dir="$1"
    local target="$2"

    # Check if the current directory exists
    if [ ! -d "$current_dir" ]; then
        echo "Error: Directory '$current_dir' does not exist."
        exit 1
    fi

    # Use find command to search for the file recursively
    result=$(find "$current_dir" -name "$target" -print -quit 2>/dev/null)

    if [ -n "$result" ]; then
        echo "File found: $(realpath "$result")"
        exit 0
    fi

    # If we've searched everything and haven't found the file
    if [ "$current_dir" = "$initial_dir" ]; then
        echo "File not found: $target"
        exit 1
    fi
}

# Check if correct number of arguments are provided
if [ $# -ne 2 ]; then
    echo "Usage: $0 <directory> <target_file>"
    exit 1
fi

initial_dir="$(realpath "$1")"
target_file="$2"

# Start the recursive search
recursive_search "$initial_dir" "$target_file"