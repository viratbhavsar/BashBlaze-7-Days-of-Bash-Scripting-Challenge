#!/bin/bash

#maximum number of restart attempts
MAX_ATTEMPTS=3

#function to check if process is running
function check_process(){
    if pgrep -x "$1" >/dev/null; then
        echo "Process $1 is running."
        return 0
    else
        return 1
    fi
}

#function to restart service
function restart_process() {
    sudo service "$1" restart >/dev/null 2>&1
    sleep 2
    if check_process "$1"; then
        echo "Process $1 restarted successfully."
        return 0
    else
        return 1
    fi
}

# Main script logic
if [ $# -eq 0 ]; then
    echo "Usage: $0 <process_name>"
    exit 1
fi

process_name="$1"
attempt=0

while [ $attempt -lt $MAX_ATTEMPTS ]; do
    if check_process "$process_name"; then
        exit 0
    else
        attempt=$((attempt + 1))
        if restart_process "$process_name"; then
            exit 0
        fi
        echo "Process $1 restart attempt $attempt of $MAX_ATTEMPTS failed."
    fi
done

echo "Process $process_name could not be restarted after $MAX_ATTEMPTS attempts."
echo "Manual intervention may be required."