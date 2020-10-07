#!/bin/bash
#
# this script demonstrates doing arithmetic

# Task 1: Remove the assignments of numbers to the first and second number variables. Use one or more read commands to get 3 numbers from the user.
# Task 2: Change the output to only show:
#    the sum of the 3 numbers with a label
#    the product of the 3 numbers with a label

firstnum= echo "Enter a number" && read firstnum
secondnum= echo "Enter a second number" && read secondnum
thirdnum= echo "Enter a third number" && read thirdnum
sumofthree=$((firstnum + secondnum + thirdnum)) && echo "The sum of the three inputs is $sumofthree"
productofthree=$((firstnum * secondnum * thirdnum)) && echo "The product of the three inputs is $productofthree"
#sum=$((firstnum + secondnum))
#dividend=$((firstnum / secondnum))
#fpdividend=$(awk "BEGIN{printf \"%.2f\", $firstnum/$secondnum}")

#cat <<EOF
#$firstnum plus $secondnum is $sum
#$firstnum divided by $secondnum is $dividend
#  - More precisely, it is $fpdividend
#EOF
