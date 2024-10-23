#!/bin/bash
#Function to display options
function display_usage() {
    echo "Usage: $0 [OPTIONS]"
    echo "Options:"
    echo "  -c, --create     Create a new user account."
    echo "  -d, --delete     Delete an existing user account."
    echo "  -r, --reset      Reset password for an existing user account."
    echo "  -l, --list       List all user accounts on the system."
    echo "  -h, --help       Display this help and exit."
}

# Function to create a new user account
function create_user() {
    echo "Creating a new user account..."
    read -p "Enter new username: " username
    if id "$username" &>/dev/null; then
        echo "Error: User '$username' already exists."
        return 1
    fi

    # Create the user account
    sudo useradd -m "$username"
    if [ $? -eq 0 ]; then
        echo "User account '$username' created successfully."
        # Set password for the new user
        sudo passwd "$username"
    else
        echo "Error: Failed to create user account '$username'."
        return 1
    fi
}

# Function to delete a user account
function delete_user() {
    echo "Deleting a user account..."
    read -p "Enter username to delete: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: User '$username' does not exist."
        return 1
    fi

    read -p "Are you sure you want to delete user '$username'? (y/N): " confirm
    if [[ $confirm =~ ^[Yy]$ ]]; then
        # Delete the user account
        sudo userdel -r "$username"
        if [ $? -eq 0 ]; then
            echo "User account '$username' deleted successfully."
        else
            echo "Error: Failed to delete user account '$username'."
            return 1
        fi
    else
        echo "Operation cancelled."
    fi
}

# Function to reset user password
function reset_password() {
    echo "Resetting user password..."
    read -p "Enter username: " username
    if ! id "$username" &>/dev/null; then
        echo "Error: User '$username' does not exist."
        return 1
    fi

    # Reset the user's password
    sudo passwd "$username"
    if [ $? -eq 0 ]; then
        echo "Password for user '$username' has been reset successfully."
    else
        echo "Error: Failed to reset password for user '$username'."
        return 1
    fi
}

# Function to list all user accounts
function list_users() {
    echo "Listing all user accounts:"
    echo "Username : UID"
    echo "-----------------"
    awk -F: '$3 >= 1000 && $3 != 65534 {print $1 " : " $3}' /etc/passwd
}

# Check if the script is run with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run with sudo or as root."
    exit 1
fi

# Check if no arguments are provided
if [ $# -eq 0 ]; then
    display_usage
    exit 1
fi

# Main script logic
while [ $# -gt 0 ]; do
    case "$1" in
        -c|--create)
            create_user
            ;;
        -d|--delete)
            delete_user
            ;;
        -r|--reset)
            reset_password
            ;;
        -l|--list)
            list_users
            ;;
        -h|--help)
            display_usage
            exit 0
            ;;
        *)
            echo "Error: Invalid option. Use -h or --help for usage information."
            exit 1
            ;;
    esac
    shift
done
