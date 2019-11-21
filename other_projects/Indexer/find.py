# Take a folder of files, take the first file "Instructions" and get the database name.
# Use that name for this folder's description.
# Assume the following - email, database description, password
# If another database is used, it will compare the passwords, if different, add to the end with the description

# Terms of Use
# You attest that you are conducting using this script to help increase awareness of the dangers of the Dark Web.
# You also agree that you will not use the information in a way that is harmful to any organization and/or individuals.
# You also acknowledge that the data breaches retrieved may not represent all data breaches and that accounts
# may have been compromised but may not show up as a part of this scan.Any data to use this script to organize is
# protected by you - the loss of the data is the holder's responsibility, no one elses.
# No Representations
# The information presented in the Dark Web Scan and the Dark Web Breach Assessment is for informational purposes only.
# All information is accessible globally from the internet. This information was collected by third parties,
# not hacked from the source. The owner of this website IN NO EVENT SHALL BE LIABLE FOR ANY SPECIAL, INDIRECT OR
# CONSEQUENTIAL DAMAGES RELATING TO THIS MATERIAL OR FOR ANY USE OF THIS WEBSITE.

#NOTE: If the fouth character is a ".", this code turns it into a "'" Make sure retrieval programs fix this.
#This code takes a directory called data
#for every file in directory
 #   for every line in file
  #      index it

import os

depth = 3

print("Enter the email address that you wish to find.")
email2Search = input()

firstList = list(email2Search) #replace . with ' for searching
try:
    for loopNum in range(4):
        if firstList[loopNum] == ".":
            firstList[loopNum] = "'"
    email2Search = "".join(firstList)
except:
    print("Small email, but okay.")
    email2Search = "".join(firstList)

indexPath = "index\\"
for count in range(depth):  # make or use folder
    # Organize index by the first # characters in email
    indexPath = indexPath + email2Search[count] + "\\"
    if os.path.isdir(indexPath):  # if the loopCount is a folder
        continue
    else:
        print("Email not found. Directories do not exist.")
        exit()

currentDirectory = indexPath+email2Search[depth]
if os.path.isfile(currentDirectory):  # if the file exists
    with open(currentDirectory, "r") as indexFile:
        found = False  # assume the email isn't in the file
        for indexLine in indexFile:  # iterate over the file one line at a time(memory efficient)
            if email2Search in indexLine:  # if string found, great. It gets converted for writing.
                found = True
                # Example = "k'marks63@yahoo.com:Breach#11,password#@!5:Breach#13,password#@!5:Breach#122"
                count = 0
                foundData = indexLine.split(':')  # index it

                foundEmail = foundData[0] #Display the email
                firstList = list(email2Search)  # return ' with . for printing
                for loopNum in range(4):
                    if firstList[loopNum] == "'":
                        firstList[loopNum] = "."
                email2Search = "".join(firstList)
                print("Found " + email2Search)

                breachNum = len(foundData)
                for breach in range(breachNum-1):
                    data = foundData[breach+1].split(',')
                    print("Breach: " + data[0] + " Password: " + data[1])


