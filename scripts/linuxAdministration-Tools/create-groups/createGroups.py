import os

def createGroups(groupList):
    print("Creating the groups!")
    for groupName in groupList:
        os.system("sudo groupadd " + groupName)  # sudo groupadd group
        print("Created group " + groupName)
    print("done")

def removeGroups(groupList):
    print("Removing the groups!:")
    for groupName in groupList:
        os.system("sudo -f –force " + groupName)  # sudo groupadd group
        print("Deleted groups " + groupName)
    print("done")

def convertStringToList(originalList):
    print("Converting names.")  # Use space as a delimiter
    newList = originalList.split(' ')

    return newList

    ###############################MAIN#################################

print("This program is used to make some groups. NOTE: You MUST run this program as root!")

print("Would you like to create a group or delete a group? (c/d)")
answer = input()

print("Type the names of the groups separated by a space.")
print("For Example: \"Admins Developers Finance Shared Temps\"")
groups = input()

if answer is "c" or answer is "C" or answer is "Create" or answer is "create":
    groupList = convertStringToList(groups) #Returns a list of groups to create
    print(groupList)
    createGroups(groupList)

elif answer is "d" or answer is "D" or answer is "Delete" or answer is "delete":
    groupList = convertStringToList(groups) #Returns a list of groups to create
    print(groupList)
    removeGroups(groupList)

