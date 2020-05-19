# This project is meant to organize a folder full of files. If you have a folder that contains
# a.something a.this a.that b.something b.this b.that c.something c.this c.that
# This will create three folders called a,b,c and put the files in them accordingly.
import os
from os import listdir
import shutil

directoryPath=r"C:\Users\das09\Downloads\Python"
print(directoryPath)

theFiles = listdir(directoryPath) #Returns a list of file names

simpleList = list()
folderCount = 0
fileCount = 0

#Remove the file extensions leaving a list of "a,a,a,b,b,b,c,c,c"
for file in theFiles:
    splitList = file.split(".")
    if len(splitList) != 2:
        print("Invalid File Name + [" + file + "]")
        exit()
    simpleList.append(splitList[0])

print("Before: [" + str(simpleList) + "]")
cleanList = list(dict.fromkeys(simpleList)) #Convert the list to a dictionary, then back. This removes all duplicates.
print("After: [" + str(cleanList) + "]")

#Create Folders called each item in the list
for folder in cleanList:
    folder2Make = directoryPath + "\\" + folder
    if not os.path.exists(folder2Make):
        print("Creating folder: [" + folder2Make + "]")
        os.makedirs(folder2Make)
    folderCount = folderCount + 1

    #Move the files
    for file in theFiles:
        splitList = file.split(".")
        if len(splitList) != 2:
            print("Invalid File Name + [" + file + "]")
            exit()
        #If the file (without extention) equals the foldername
        if splitList[0] == folder:
            #Move the file to the new folder. So move "path/to/current/file.foo" , "path/to/new/destination/for/file.foo"
            shutil.move(directoryPath + "\\" + file, directoryPath + "\\" + folder + "\\" + file)
            print("Moved [" + directoryPath + "\\" + file + "] to [" + directoryPath + "\\" + folder + "\\" + file + "]")
        fileCount = fileCount + 1

    print("Done. Folders Created: [" + str(folderCount) + "] Files moved: [" + str(fileCount) + "]")

