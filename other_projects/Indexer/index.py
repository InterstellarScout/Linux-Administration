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

# NOTE: If the fouth character is a ".", this code turns it into a "'" Make sure retrieval programs fix this.
# This code takes a directory called data
# for every file in directory
#   for every line in file
#      index it

import os
# for file_len
from os import listdir
from os.path import isfile, join
# for Replace
from tempfile import mkstemp
from shutil import move
from os import fdopen, remove


def file_len(
        fname):  # https://stackoverflow.com/questions/845058/how-to-get-line-count-of-a-large-file-cheaply-in-python
    with open(fname) as f:
        count = 0
        for l in enumerate(f):
            count = count + 1
    f.close()
    return count


def replace(file_path, pattern, subst):
    # Create temp file
    fh, abs_path = mkstemp()
    with fdopen(fh, 'w') as new_file:
        with open(file_path) as old_file:
            for line in old_file:
                new_file.write(line.replace(pattern, subst))
    # Remove original file
    remove(file_path)
    # Move new file
    move(abs_path, file_path)


# Get the name of this data being added
dataName = "Breach#1"

# Get the Files that we will be indexing
path = "data/"
fileList = [f for f in listdir(path) if isfile(join(path, f))]
print(type(fileList))
print(fileList)

for file in fileList:  # for each file
    file = path + file
    try:
        flength = file_len(file)
        print("There are " + str(flength) + " lines in " + file)
        loopCount = 0

        origIndexPath = "index\\"
        with open(file) as f:
            for line in f:  # for each line
                loopCount = loopCount + 1
                if loopCount % 10000 == 0:
                    print(loopCount)
                indexPath = origIndexPath  # reset the path for the new line
                depth = 3  # This variable decides how deep the indexing goes.

                # Example = "angi20_2201@yahoo.com:password#@!1"
                line = line.split(':')  # index it
                first = line[0]  # First = angi20_2201@yahoo.com
                second = line[1]  # Second = password#@!1
                dataToAppend = dataName + "," + second

                # firstList = list(first)
                # if firstList[0] == ".":
                #     firstList[0] = "'"
                # if firstList[1] == ".":
                #     firstList[1] = "'"
                # if firstList[2] == ".":
                #     firstList[2] = "'"
                # if firstList[3] == ".":
                #     firstList[3] = "'"
                # first = "".join(firstList)
                firstList = list(first)
                for loopNum in range(4):
                    if firstList[loopNum] == ".":
                        firstList[loopNum] = "'"
                first = "".join(firstList)
                # print(first)

                for count in range(depth):  # make or use folder
                    # Organize index by the first # characters in email
                    indexPath = indexPath + first[count] + "\\"
                    if os.path.isdir(indexPath):  # if the loopCount is a folder
                        continue
                    else:
                        os.system("mkdir " + indexPath)

                # When we reach this, we should have our proper path for the current line.
                # create a file using the fourth letter
                currentDirectory = indexPath + first[depth]
                if os.path.isfile(currentDirectory):  # if the file exists
                    # print("Found, adding.")
                    with open(currentDirectory, "r") as indexFile:
                        found = False  # assume the email isn't in the file
                        for indexLine in indexFile:  # iterate over the file one line at a time(memory efficient)
                            # print("checking if " + first + " in " + indexLine[:-1])
                            # print(first in indexLine)
                            if first in indexLine:  # if string found, then check if current dataName is in it. If not in it, add to the line using :
                                found = True
                                # print("found " + first)
                                # print(dataName in indexLine)
                                if dataName in indexLine:  # if the data name is found
                                    # print("skipping " + indexLine)
                                    continue  # skip adding anything
                                else:
                                    # edit the line. Python cannot "edit" a file. It can append and delete.
                                    # edit the current file with the changes.
                                    # print("adding " + indexLine)
                                    indexFile.close()
                                    replace(currentDirectory, indexLine, indexLine[:-1] + ":" + dataToAppend)
                                    break
                    indexFile.close()  # close the file

                    if not found:
                        with open(currentDirectory, "a") as indexFile:
                            # print("adding " + first)
                            indexFile.write(first + ":" + dataToAppend)
                            indexFile.close()  # close the file

                else:  # the file to save to does not exist, so create it.
                    # print("doesn't exist. Creating")
                    # create the file and append to it
                    try:
                        with open(currentDirectory, "a") as indexFile:
                            indexFile.write(first + ":" + dataToAppend)
                            indexFile.close()
                    except:
                        with open("log.txt", "a") as logFile:
                            print(first + " could not be added. Invalid Name.")
                            logFile.write(first + " could not be added. Invalid Name.")
                        logFile.close()

        with open("log.txt", "a") as logFile:
            print(file + " has been concluded.")
            logFile.write(file + " has been concluded with " + str(flength) + " lines.\n")
            logFile.close()

        f.close()
    except:
        with open("log.txt", "a") as logFile:
            print(file + " has failed. A character in the file could not be read.")
            logFile.write(file + " has failed. A character in the file could not be read.\n")
            logFile.close()





