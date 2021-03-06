import os
import crypt
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
        #print(contents)
        rowContents = contents.split('\n') #make a list consisting of the rows
        #print(rowContents)
        dataContents = []

        for row in rowContents:
            dataContents.append(row.split(',')) #make a list consisting of the rows

        print(dataContents)
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

        print(finalList)
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


def createUsers(usernameList,passwordList):  # takes in a list of users and passwords, then adds them in mass.
    print("Creating the users:")
    for count, item in enumerate(usernameList):
        print(item)#username
        print(passwordList[count])#password
        encPass = crypt.crypt(passwordList[count], "22")  # 22 is a salt number, use crypt per useradd manual
        os.system("sudo useradd -m -p " + encPass + " " + item)  # useradd -m -p encryptedpass username -G group1
        print("done adding " + item)


def removeUsers(usernameList):
    print("Removing the users:")
    for count, aName in enumerate(usernameList):
        os.system("sudo userdel -r " + aName)  # userdel -r (to also delete the directory) to delete users.
        print(aName + " has been deleted.")

    print("done.")


    ####################################################################
    ############################   MAIN   ##############################
    ####################################################################


print("This program is used to make some users.")
print("The file being imported must be a txt named \"users.txt\".")
print("Save the file in the directory from which this is being ran.")
print("Would you like to create or delete the users? c/d")
nameList = importFile("users.txt")  # this will return a list of lists containing the user information.
answer = input()
if answer == "d" or answer == "D" or answer == "delete" or answer == "Delete": #Delete Users
    print("Deleting Users.")
    usernames = convertNameToUsernames(nameList)
    removeUsers(usernames)

else: #Create Users
    print("Creating Users.")
    usernames = convertNameToUsernames(nameList)
    passwords = getPasswords(nameList)
    createUsers(usernames, passwords)

print("You're all set. Have a good one!")

