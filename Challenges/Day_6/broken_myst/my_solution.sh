#!/bin/bash

# The Mysterious Function
mysterious_function() {
    local input_file="$1"     # Store the first argument as the input file
    local output_file="$2"    # Store the second argument as the output file
    
    # Apply ROT13 transformation to the content of the input file and write it to the output file
    tr 'A-Za-z' 'N-ZA-Mn-za-m' < "$input_file" > "$output_file"

    # Reverse the content of the output file and store it in a temporary file
    rev "$output_file" > "reversed_temp.txt"

    # Generate a random number between 1 and 10 (inclusive)
    random_number=$(( ( RANDOM % 10 ) + 1 ))

    # Mystery loop: Repeat the process a random number of times
    for (( i=0; i<$random_number; i++ )); do
        # Reverse the content of the temporary file and store it in another temporary file
        rev "reversed_temp.txt" > "temp_rev.txt"

        # Apply ROT13 transformation again to the reversed file and store it in another temporary file
        tr 'A-Za-z' 'N-ZA-Mn-za-m' < "temp_rev.txt" > "temp_enc.txt"

        # Overwrite the previous temporary file with the newly transformed file
        mv "temp_enc.txt" "reversed_temp.txt"
    done

    # Clean up temporary files (removing the temporary file used for reversal)
    rm "temp_rev.txt"

    # The mystery continues...
    # The script will continue with more operations that you need to figure out!
}

# Main Script Execution

# Check if exactly two arguments are provided (input and output files)
if [ $# -ne 2 ]; then
    echo "Usage: $0 <input_file> <output_file>"
    exit 1
fi

input_file="$1"
output_file="$2"

# Check if the input file exists and is a regular file
if [ ! -f "$input_file" ]; then
    echo "Error: Input file not found!"
    exit 1
fi

# Call the mysterious function to begin the process with the provided input and output files
mysterious_function "$input_file" "$output_file"

# Display a message indicating the process is complete
echo "The mysterious process is complete. Check the '$output_file' for the result!"
