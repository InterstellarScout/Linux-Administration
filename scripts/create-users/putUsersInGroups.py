import os
import sys
import csv
import re
import random


# Optional features for later
# Take .csv files with names and passwords, then make them into users.
# Take a password file and add them to the users accordingly

def importFile(fileName):
    try:
        file = open(fileName, "r")
        contents = file.read()
        rowContents = contents.split('\n') #make a list consisting of the rows
        dataContents = []

        for row in rowContents:
            dataContents.append(row.split(',')) #make a list consisting of the rows

        file.close()

        try:#Delete first row and crap entries
            finalList = []
            for item in dataContents:
                if item[0] == 'first name':
                    print("nope")
                elif item[0] is "":
                    print("nope")
                else:
                    finalList.append(item)
        except:
            print("Something went wrong")
            exit()

        return finalList

    except:
        print("The file was not found.")
        print("Make sure the file you need is in the working directory (where you ran this program)")

        exit()


def getPasswords(nameList):
    passwordList = []  # used to hold the new usernames

    for count, aName in enumerate(nameList):  # this does not need to be enumerated.
        passwordList.append("$ecur3P433W0rd")

    print(passwordList)

    return passwordList

def convertListToStrings(OriginalList):
    GroupList = []  # used to hold the new usernames
    for count, aGroup in enumerate(OriginalList):  # this does not need to be enumerated.
        preConvert = re.split('\W+', str(aGroup)) #Returns [ '', 'developers', '' ]
        GroupList.append(preConvert[1])  # Add the username to the user list

    print(GroupList)
    return GroupList

def convertNameToUsernames(nameList):
    print("Creating usernames:")
    usernameList = []  # used to hold the new usernames

    for count, aName in enumerate(nameList):  # this does not need to be enumerated.
        preConvert = re.split('\W+', str(aName))  # Split the name into only text, excluding all hyphens and quotes.

        # take the first letter of the first string
        for count, position in enumerate(preConvert[1]):  # take first word
            if count is 0:
                letter = position.lower()  # Takes the first letter and makes it lowercase

        wordCount = len(preConvert)  # get the legnth of the user's name

        username = letter + preConvert[wordCount - 2].lower()  # Combine the first letter and lowercase last name

        usernameList.append(username)  # Add the username to the user list

    print(usernameList)
    return usernameList


def addToGroup(usernameList,groupList):  # takes in a list of users and passwords, then adds them in mass.
    print("Adding Users to Groups:")
    for count, item in enumerate(usernameList):
        print(item + " is bring added to: " + str(groupList[count]))#username
        os.system("sudo usermod -a -G " + groupList[count] + " " + item)  # usermod -a -G sudo geek
        print("done")

    ####################################################################
    ############################   MAIN   ##############################
    ####################################################################


print("This program is used to make some users.")
print("The file being imported must be a txt named \"users.txt\".")
print("Save the file in the directory from which this is being ran.")
print("Would you like to create or delete the users? c/d")
nameList = importFile("users.txt")  # this will return a list of lists containing the user information.
print(nameList)
groupList = importFile("groups.txt")
print(groupList)

usernames = convertNameToUsernames(nameList)
finalGroupList = convertListToStrings(groupList)

print("Adding users to Groups")
addToGroup(usernames, finalGroupList)

print("You're all set. Have a good one!")

