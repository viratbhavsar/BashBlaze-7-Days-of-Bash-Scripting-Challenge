#!/bin/bash

echo "Welcome to the Interactive File and Directory Explorer!"

while true; do
    # List all files and directories in the current path
    echo "Files and Directories in the Current Path:"
    ls -lh

    # Read user input with prompt
    read -p "Enter a line of text (Press Enter without text to exit): " input

    # Exit if the user enters an empty stringThe -z option in shell scripting is used with conditional statements to check if a string is empty.
    #
    if [[ -z "$input" ]]; then
        echo "Exiting the Interactive Explorer. Goodbye!"
        break
    fi

    # Calculate and print the character count for the input line
    #Used ${#input} to count characters directly from the variable, which is more efficient than invoking external commands like wc -m.
    echo "Character Count: ${#input}"
done