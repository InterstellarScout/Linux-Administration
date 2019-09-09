import os
import crypt
import sys
import re
import random


# Optional features for later
# Take .crv files with names and passwords, then make them into users.
# Take a password file and add them to the users accordingly

def importFile(fileName):
    try:
        file = open(fileName, "r")
        contents = file.read()
        print(contents)
        file.close()

        return contents

    except:
        print("The file was not found.")
        print("Make sure the file you need is in the working directory (where you ran this program)")

        exit()


def createUser():
    user = "jsmith"
    password = "password"

    print("What is the user's username?")
    user = input()

    print("What is the user's password?")
    password = input()

    encPass = crypt.crypt(password, "22")  # 22 is a salt number, use crypt per useradd manual
    os.system("useradd -p " + encPass + " " + user)  # useradd -p encryptedpass username

    print("done")
    return user


def createPasswordList(nameList):
    print("They are being given the standard password of \"p@ssw0rd.\"")
    passList = []

    for i in nameList:
        passList.append("p@ssw0rd")

    print(passList)
    return passList


def createUsers(usernameList, passwordList):  # takes in a list of users and passwords, then adds them in mass.
    print("Creating the users:")
    for count, aName in enumerate(usernameList):
        print(aName)
        print(passwordList[count])
        encPass = crypt.crypt(passwordList[count], "22")  # 22 is a salt number, use crypt per useradd manual
        os.system("useradd -p " + encPass + " " + aName)  # useradd -p encryptedpass username

    print("done.")


def removeUsers(usernameList):
    print("Removing the users:")
    for count, aName in enumerate(usernameList):
        print(aName)
        os.system("userdel -r " + aName)  # userdel -r (to also delete the directoy) to delete users.

    print("done.")


def convertStringToList(originalList):
    print("Converting names.")  # Use newline as a delimiter
    newList = originalList.split('\n')

    return newList


def convertNameToUsernames(nameList):
    print("Creating usernames:")
    preConvert = []  # used as a temp list for conversion
    usernameList = []  # used to hold the new usernames

    for count, aName in enumerate(nameList):  # this does not need to be enumerated.
        preConvert = re.split('\W+', aName)  # Split the name into only text, excluding all hyphens and quotes.

        # take the first letter of the first string
        for count, position in enumerate(preConvert[0]):  # take first word
            if count == 0:
                letter = position.lower()  # Takes the first letter and makes it lowercase

        wordCount = len(preConvert)  # get the legnth of the user's name

        username = letter + preConvert[wordCount - 1].lower()  # Combine the first letter and lowercase last name

        usernameList.append(username)  # Add the username to the user list

    print(usernameList)
    return usernameList

    ###############################MAIN#################################


print("This program is used to make some users.")
print("If you import a file, have it in the working directory called \"names.txt\".")

print("Would you like to import names or add them manually? (n/m)")
answer = input()

if (answer is 'm' or answer is 'M'):
    usersCreated = []

    while answer != "n" and answer != "N":
        usersCreated.append(createUser())
        print("The user is created. Would you like to make another one? (y/n)")
        answer = input()
        print(answer)

    print("Would you like to delete all created users? (y/n)")
    answer = input()
    if answer == 'y' or answer == 'Y':
        removeUsers(usersCreated)
        print("done.")

    print("You're all set. Have a good one!")

else:
    originalNames = importFile("names.txt")  # this will return a string of the file.
    nameList = convertStringToList(originalNames)  # convert the string to sets of names. Use newlines as delimiters.
    print("done")
    userNameList = convertNameToUsernames(nameList)  # convert the names to usernames

    print("Do the users have a password list? (y/n)")
    answer = input()
    # answer = 'n' ###FORCE###
    if (answer == 'n' or answer == 'N'):
        passwordList = createPasswordList(nameList)
    elif (answer == 'y' or answer == 'Y'):
        print("The file needs to be called \"passwords.txt\" and must be in the working directory.")
        print("The passwords should be in the same order as the users, and be seperated with new lines.")
        passwordList = importFile("passwords.txt")
        passwordList = convertStringToList(passwordList)
    else:
        print("you imported something bad. ABORT!")
        exit()

    # At this point we have the usernames and passwords. Lets create the users
    createUsers(userNameList, passwordList)

    print("Would you like to delete all created users? (y/n)")
    answer = input()
    if answer == 'y' or answer == 'Y':
        removeUsers(userNameList)
        print("done.")

    print("You're all set. Have a good one!")

