import os
#import crypt
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


def createUsers(infoList):  # takes in a list of users and passwords, then adds them in mass.
    print("Creating the users:")
    for count, item in enumerate(infoList):
        print(item[2])#username
        print(item[3])#password
        print(item[4])#group1
        print(item[5])#group2
        encPass = 5#crypt.crypt(passwordList[4], "22")  # 22 is a salt number, use crypt per useradd manual
        #os.system("useradd -m -p " + encPass + " " + username)  # useradd -p encryptedpass username
        if item[5] is 0:
            print("useradd -m -p " + str(encPass) + " " + item[2] + " -G " + item[4])  # useradd -m -p encryptedpass username -G group1
    print("done.")


def removeUsers(usernameList):
    print("Removing the users:")
    for count, aName in enumerate(usernameList):
        print(aName)
        os.system("userdel -r " + aName)  # userdel -r (to also delete the directory) to delete users.

    print("done.")


    ####################################################################
    ############################   MAIN   ##############################
    ####################################################################


print("This program is used to make some users.")
print("The file being imported must be a csv named \"users.csv\".")
print("Save the file in the directory from which this is being ran.")
print("The fields required are: first name	last name	username	password	group	group2")
print("Note, fields 1 and 2 are disregarded so you can use the follow command in excel:")
print("=LOWER(CONCATENATE(LEFT(A2,1),B2))")

infoList = importFile("users.csv")  # this will return a list of lists containing the user information.
#[['first name', 'last name', 'username', 'password', 'group', 'group2', '', '', '', '', '', '', ''], ['Bob', 'Sagget', 'bsagget', 'Changeme!', 'temp', '', '', '', '', '', '', '', ''], ['Jessica', 'Sampson', 'jsampson', 'Changeme!', 'financial', '', '', '', '', '', '', '', ''], ['John', 'Sussenberger', 'jsussenberger', 'Adm1nUs3r', 'admin', 'wheel', '', '', '', '', '', '', ''], ['Jason', 'Termini', 'jtermini', 'Changeme!', 'staff', '', '', '', '', '', '', '', ''], ['John', 'Smith', 'jsmith', 'Changeme!', 'temp', '', '', '', '', '', '', '', ''], ['Rachel', 'Sussenberger', 'rsussenberger', 'Changeme!', 'financial', '', '', '', '', '', '', '', ''], ['Rick', 'Sanchez', 'rsanchez', 'Changeme!', 'developers', '', '', '', '', '', '', '', ''], ['Barrak', 'Obama', 'bobama', 'Changeme!', 'staff', '', '', '', '', '', '', '', ''], ['']]

#createUsers(usernames, passwords, group1, group2)
createUsers(infoList)

print("done")
#userNameList = convertNameToUsernames(nameList)  # convert the names to usernames


# At this point we have the usernames and passwords. Lets create the users
#createUsers(userNameList, passwordList)

print("Would you like to delete all created users? (y/n)")
answer = input()
if answer == 'y' or answer == 'Y':
    #removeUsers(userNameList)
    print("done.")

print("You're all set. Have a good one!")

