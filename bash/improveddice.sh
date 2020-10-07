#!/bin/bash
#
# this script rolls a pair of six-sided dice and displays both the rolls
#

# Task 1:
#  put the number of sides in a variable which is used as the range for the random number
num_of_sides=6
#  put the bias, or minimum value for the generated number in another variable
min=1
#  roll the dice using the variables for the range and bias i.e. RANDOM % range + bias
echo "Rolling Dice"
firstRole=$(( RANDOM % (num_of_sides + min)))
secondRole=$(( RANDOM % (num_of_sides + min)))

# Task 2:
#  generate the sum of the dice
sum=$((firstRole + secondRole))
#  generate the average of the dice
avg=$((sum / 2))
#  display a summary of what was rolled, and what the results of your arithmetic were
echo "Die 1 rolled $firstRole"
echo "Die 2 rolled $secondRole"
echo "The sum is $sum"
echo "The average is $avg"
# Tell the user we have started processing
echo "Rolling..."
# roll the dice and save the results
die1=$(( RANDOM % 6 + 1))
die2=$(( RANDOM % 6 + 1 ))
# display the results
echo "Rolled $die1, $die2"
