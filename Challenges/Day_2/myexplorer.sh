#!/bin/bash

echo "Welcome to the Interactive File and Directory Explorer!"
while true; do
        echo -e "\nFiles and Directories in Current Path"
        ls -lh

        echo -e "\nEnter a line of text(Press Enter without text to exit):"
        read -r input
        if [ -z "$input" ]; then
            echo "Exiting the Interactive Explorer. Goodbye!"
            exit 0
        fi
        char_count=${#input}
        echo "Character Count: $char_count"
done
