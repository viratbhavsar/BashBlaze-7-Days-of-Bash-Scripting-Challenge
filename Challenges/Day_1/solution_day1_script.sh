#!/bin/bash


#Task1:Comment
#by this hashtag we can give oneline comment and exclude any particular line of code by this.

<<comment
this is multiline
comment to explain what is script about and lots of 
explaination u can give so this is syntax to write multiline comment 
and you can give anyname like i have given comment but main thing is that the end name should be same.
comment

#Task:2
#this echo is use to print or display msg in terminal 
echo "hello dosto"

#Task:3
#Variables in bash are used to store data and can be referenced by their name. 
name="faizan" #here i am assigning the name variable with value faizan.
echo "hello $name" #here i am acessing that variable using $ symbol.

#Task 4: Using Variables
#Now that you have declared variables, let's use them to perform a simple task. Create a bash script that takes two variables (numbers) as input and prints their sum using those variables.

num1=4
num2=4
echo "sum of num1 and num2 is  $(( $num1 + $num2 ))"

#Task:5 built in variables
echo "print the present working directory with help of $PWD"
echo "print user $USER"
echo "$SHELL"

#Task 6: Wildcards
echo "Files with .txt extension in the current directory:"
ls *.txt


#Make sure to provide execution permission with the following command:
#chmod +x day1_script.sh
