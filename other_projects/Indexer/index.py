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

#This code takes a directory called data
#for every file in directory
 #   for every line in file
  #      index it

import os
import re
from os import listdir
from os.path import isfile, join


def file_len(fname): #https://stackoverflow.com/questions/845058/how-to-get-line-count-of-a-large-file-cheaply-in-python
    with open(fname) as f:
        count = 0
        for l in enumerate(f):
            count = count + 1
    return count

#Get the name of this data being added
dataName="Breach#21"

#Get the Files that we will be indexing
path = "data/"
fileList = [f for f in listdir(path) if isfile(join(path, f))]
print(type(fileList))
print(fileList)

for file in fileList:  #for each file
    file = path+file
    flength = file_len(file)
    print("There are " + str(flength) + " lines in " + file)

    origIndexPath="index\\"
    with open(file) as f:
        for line in f:  #for each line
            indexPath=origIndexPath  #reset the path for the new line
            depth = 3  # This variable decides how deep the indexing goes.

            #Example = "angi20_2201@yahoo.com:password#@!1"
            line = line.split(':')      #index it
            first = line[0]  # First = angi20_2201@yahoo.com
            second = line[1]  # Second = password#@!1
            dataToAppend = dataName + "," + second + ":"

            for count in range(depth):  #make or use folder
                #Organize index by the first # characters in email
                indexPath = indexPath+first[count]+"\\"
                if os.path.isdir(indexPath):  #if the loopCount is a folder
                    continue
                else:
                    os.system("mkdir " + indexPath)

            #When we reach this, we should have our proper path for the current line.
            #create a file using the fourth letter
            currentDirectory = indexPath+first[depth+1]
            if os.path.isfile(currentDirectory):  #if the file exists
                print("Found, adding.")
                with open(currentDirectory, "w") as indexFile:
                    found = False  #assume the email isn't in the file
                    for indexLine in indexFile:  #iterate over the file one line at a time(memory efficient)
                        print("checking")
                        if first in indexLine:  #if string found, then check if current dataName is in it. If not in it, add to the line using :
                            print("found " + first)
                            print(dataName in indexLine)
                            if dataName in indexLine:  #if the data name is found
                                print("skipping " + indexLine)
                                continue  #skip adding anything
                            else:
                                print("adding " + indexLine)
                                indexLine = indexLine+dataToAppend
                    found = True
                indexFile.close()  # close the file

                if not found:
                    with open(currentDirectory, "a+") as indexFile:
                        print("adding " + first)
                        indexFile.write(first + ":" + dataToAppend)
                    indexFile.close()  #close the file

            else:
                print("doesn't exist. Creating")
                # create the file and append to it
                with open(currentDirectory, "w+") as indexFile:
                    indexFile.write(first + ":" + dataToAppend)
                indexFile.close()




