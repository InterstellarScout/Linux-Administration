#!/bin/bash
#Get Information
echo Hey, what would you like the program to say?
read phrase
echo $phrase
echo How many times would you like this to run?
loopNum=5
read loopNum
echo We will loop $loopNum times

#Display the phrase x number of times
counter=0
while [ $counter -lt $loopNum ];
do
echo $phrase
counter=$(($counter+1))
done

#count down from above number
while [ $loopNum -gt 0 ];
do
echo $loopNum
loopNum=$(($loopNum-1))
done