#!/bin/sh
#This script will print is disk usage report. This script is incomplete.
#get the drives inuse:

df -aTh > totalOutput
variable1=`cat totalOutput`
awk -F"[ ]" '/dev/{print $2}' checkme! > whatIWant

