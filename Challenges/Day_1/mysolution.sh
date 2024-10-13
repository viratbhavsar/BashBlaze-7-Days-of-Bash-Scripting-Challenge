#!/bin/bash

# Task 1: Comments
# This script demonstrates basic bash scripting concepts including
# comments, echo, variables, arithmetic, built-in variables, and wildcards.
<< comment
This is also a comment
comment

# Task 2: Echo
echo "Welcome to the Bash Scripting Challenge - Day 1!"

# Task 3: Variables
name="Kanav"
age=23
echo  "variable 1 is string with value $name"
echo  "variable 2 is int with value $age"

# Task 4: Using Variables
num1=10
num2=20
sum=$((num1 + num2))
echo "The sum of $num1 and $num2 is: $sum"

# Task 5: Using Built-in Variables
echo "Current user: $USER"
echo "Home directory: $HOME"
echo "Current working directory: $PWD"

# Task 6: Wildcards
echo "Listing all .txt files in the current directory:"
ls *.txt
