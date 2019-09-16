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

        #print(dataContents)
        file.close()

        try:#Delete first row and crap entries
            finalList = []
            for item in dataContents:
                if item[0] == 'first name':
                    print("")
                elif item[0] is "":
                    print("")
                else:
                    finalList.append(item)
        except:
            print("Something went wrong")
            exit()

        #print(finalList)
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
        encPass = crypt.crypt(item[3], "22")  # 22 is a salt number, use crypt per useradd manual
        os.system("sudo useradd -m -p " + encPass + " " + item[2])  # useradd -p encryptedpass username
    print("done.")


def removeUsers(usernameList):
    print("Removing the users:")
    for count, item in enumerate(usernameList):
        print(item[2])#username
        print(item[3])#password
        print(item[4])#group1
        os.system("sudo userdel -r " + item[2])  # userdel -r (to also delete the directory) to delete users.
        print(item[2] + " has been deleted.")

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
print("Now, would you like to create or delete the above users? c/d")

infoList = importFile("users.csv")  # this will return a list of lists containing the user information.
#[['first name', 'last name', 'username', 'password', 'group', 'group2', '', '', '', '', '', '', ''], ['Bob', 'Sagget', 'bsagget', 'Changeme!', 'temp', '', '', '', '', '', '', '', ''], ['Jessica', 'Sampson', 'jsampson', 'Changeme!', 'financial', '', '', '', '', '', '', '', ''], ['John', 'Sussenberger', 'jsussenberger', 'Adm1nUs3r', 'admin', 'wheel', '', '', '', '', '', '', ''], ['Jason', 'Termini', 'jtermini', 'Changeme!', 'staff', '', '', '', '', '', '', '', ''], ['John', 'Smith', 'jsmith', 'Changeme!', 'temp', '', '', '', '', '', '', '', ''], ['Rachel', 'Sussenberger', 'rsussenberger', 'Changeme!', 'financial', '', '', '', '', '', '', '', ''], ['Rick', 'Sanchez', 'rsanchez', 'Changeme!', 'developers', '', '', '', '', '', '', '', ''], ['Barrak', 'Obama', 'bobama', 'Changeme!', 'staff', '', '', '', '', '', '', '', ''], ['']]
answer = input()
if answer == "d" or answer == "D" or answer == "delete" or answer == "Delete": #Delete Users
    print("Deleting Users.")
    removeUsers(infoList)

else: #Create Users
    print("Creating Users.")
    createUsers(infoList)

print("You're all set. Have a good one!")
