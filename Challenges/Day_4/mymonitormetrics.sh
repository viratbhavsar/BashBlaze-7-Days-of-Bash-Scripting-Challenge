#!/bin/bash

# Function to display CPU usage
function show_cpu_usage {
    echo "CPU Usage:"
    top -b -n1 | grep "Cpu(s)" | awk '{print $2 + $4}' | sed 's/^/  /'
}

# Function to display memory usage
function show_memory_usage {
    echo "Memory Usage:"
    free -h | grep "Mem" | awk '{print "  Used: " $3 " / Total: " $2}'
}

# Function to display disk space usage
function show_disk_space {
    echo "Disk Space Usage:"
    df -h | grep '^/dev/' | awk '{print "  Partition: " $1 ", Used: " $3 " / Total: " $2}'
}

# Function to monitor a specific service
function monitor_service {
    read -p "Enter the name of the service you want to monitor (default: nginx): " service
    service=${service:-nginx}
    if systemctl is-active --quiet "$service"; then
        echo "$service is running."
    else
        echo "$service is not running."
        read -p "Would you like to start $service? (y/n): " choice
        if [ "$choice" == "y" ]; then
            if sudo systemctl start "$service"; then
                echo "$service has been started successfully."
            else
                echo "Failed to start $service. Please check the service name or your permissions."
            fi
        fi
    fi
}

# Function to display the main menu
function main_menu {
    while true; do
        echo "System Metrics Monitoring Script"
        echo "--------------------------------"
        echo "1. View CPU usage"
        echo "2. View Memory usage"
        echo "3. View Disk space usage"
        echo "4. Monitor a specific service"
        echo "5. Exit"
        echo "--------------------------------"
        read -p "Choose an option [1-5]: " option
        case $option in
            1) show_cpu_usage ;;
            2) show_memory_usage ;;
            3) show_disk_space ;;
            4) monitor_service ;;
            5) echo "Exiting..."; exit 0 ;;
            *) echo "Invalid option. Please try again."; sleep 2 ;;
        esac
        read -p "Enter sleep interval (in seconds) for continuous monitoring (or press Enter to skip): " interval
        if [[ $interval =~ ^[0-9]+$ ]]; then
            sleep "$interval"
        fi
    done
}

# Start the script by displaying the menu
main_menu
