#!/bin/bash

# Function to read and display the menu from menu.txt file
function display_menu() {
    echo "Welcome to the Restaurant!"
    echo "Menu:"
    local item_number=1
    while IFS=',' read -r item price; do
        printf "%d. %s - ₹%s\n" "$item_number" "$item" "${price## }"
        ((item_number++))
    done < menu.txt
}

# Function to calculate the total bill
function calculate_total_bill() {
    local total=0
    local item_number=1
    while IFS=',' read -r item price; do
        if [[ -n "${order[$item_number]}" ]]; then
            total=$((total + ${price## } * ${order[$item_number]}))
        fi
        ((item_number++))
    done < menu.txt
    echo "$total"
}

# Function to handle invalid user input
function handle_invalid_input() {
    echo "Invalid input! Please enter a valid item number and quantity."
}

# Function to validate input
function validate_input() {
    local item_number=$1
    local quantity=$2
    local max_items=$(wc -l < menu.txt)

    if ! [[ "$item_number" =~ ^[0-9]+$ ]] || ! [[ "$quantity" =~ ^[0-9]+$ ]] || 
       [ "$item_number" -lt 1 ] || [ "$item_number" -gt "$max_items" ] || [ "$quantity" -lt 1 ]; then
        return 1
    fi
    return 0
}

# Main script
display_menu

# Ask for the customer's name
read -p "Please enter your name: " customer_name

# Ask for the order
declare -A order
while true; do
    echo "Please enter the item number and quantity (e.g., 1 2 for two Burgers), or press Enter to finish:"
    read -a input_order

    # Check if the order is complete
    if [ ${#input_order[@]} -eq 0 ]; then
        break
    fi

    # Validate input
    if [ ${#input_order[@]} -ne 2 ] || ! validate_input "${input_order[0]}" "${input_order[1]}"; then
        handle_invalid_input
        continue
    fi

    item_number="${input_order[0]}"
    quantity="${input_order[1]}"

    # Add the item to the order
    if [ -n "${order[$item_number]}" ]; then
        order[$item_number]=$((order[$item_number] + quantity))
    else
        order[$item_number]=$quantity
    fi

    echo "Added to your order. Anything else?"
done

# Calculate the total bill
total_bill=$(calculate_total_bill)

# Display the order summary
echo "Order Summary:"
item_number=1
while IFS=',' read -r item price; do
    if [[ -n "${order[$item_number]}" ]]; then
        printf "%s x%d - ₹%d\n" "$item" "${order[$item_number]}" "$((${price## } * ${order[$item_number]}))"
    fi
    ((item_number++))
done < menu.txt

# Display the total bill with a personalized thank-you message
echo "Thank you, $customer_name! Your total bill is ₹$total_bill."