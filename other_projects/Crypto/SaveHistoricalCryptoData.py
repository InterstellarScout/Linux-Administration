# Dean Sheldon
# Network Up/Down Tracker
# Displays current pings and appends them all to a data file.
# Works for sure with Python 3.4
# Works for sure on Windows

import csv  # Needed for exporting to csv (easily)
from datetime import datetime # Needed for date and time
import platform  # For getting the operating system name
import subprocess  # For executing a shell command
import re  # Used for splitting
import time  # gives us the sleep function
import os  # Allows us to see the PID for process manager.
import sys  # Allows us to call python in cmd to use arguments
import binance

#############################File Management####################################

def getTitle(Format):
    time = datetime.now()

    print("Type the function of this program. (I.E. Second-Tracking, Minute-Tracking)")
    # answer = input()
    answer = "CryptoPrice-Seconds-"  ####FORCE#####

    finalTitle = time.strftime("%Y-%m-%d")
    finalTitle = answer + finalTitle

    title = addTxt(finalTitle)

    return title


def addTxt(string):
    list1 = []
    list1.append(string)
    ext = "csv"
    fullExt = ".csv"

    # test if .txt is already in name
    list1 = string.split(".")  # replace values with two new values
    list1.append(".")
    print(list1)
    empty = "."
    required = ext

    if list1[1] is not required:
        list1[1] = fullExt

    if list1[1] is empty:
        list1.append(fullExt)

    # print(list1)
    return ''.join(list1)

###########################Add Data to File##################################

def AppendToFileCSVDict(DictionaryToSave, title):
    time = datetime.now()
    DateNow = time.strftime("%Y-%m-%d,")
    TimeNow = time.strftime("%H:%M:%S,")
    my_dict = {'1': 'aaa', '2': 'bbb', '3': 'ccc'}
    #my_dict = binance.prices()
    #We have a dictionary {'ETHBTC': '0.02198200', 'LTCBTC': '0.00945600'...}
    with open(title, 'a+') as dataFile:
        dataFile.write(DateNow)
        dataFile.write(TimeNow)
        for key in DictionaryToSave.keys():
            dataFile.write("%s,%s," % (key, DictionaryToSave[key]))
        dataFile.write("\n")
    print("Saved")

def checkIfDelete(count):
    if count > 50:
        #Delete the earliest line, and replace
        print("Delete")

###############################Get Data#####################################

def getPrices(): #Returns a dictionary
    currentPriceDictionary = binance.prices()
    #We have a dictionary {'ETHBTC': '0.02198200', 'LTCBTC': '0.00945600'...}
    #print(priceList['ETHBTC'])
    return currentPriceDictionary #A Dictionary

############################################################################

def Banner():
    print("|=================================|")
    print("|         Crypto Tracker          |")
    print("|=================================|\n")


def Main():
    ##################FORCES#####################
    Format = 1  # 0 to save as txt, 1 to save as csv
    Time = 0  # Set the time: 0 for 1 second, 1 for 60 seconds, 2 for 5 minutes
    ###################END FORCES################
    print("Welcome to CryptoTracker!")

    print("Would you like to Set the time: (0) for 1 second, (1) for 60 seconds, or (2) for 5 minutes")
    #Time = input() #Take in the inputs - 0
    print("What is the max number of entries?")
    #maxEntries = input()

    print("Perfect. This program will run contiously. To stop, press CTRL-C or Z, depending on your system.")
    title = getTitle(Format)  # The tile of the working file
    print("The file is saving as", title)

    count = 0
    while True:  # Infinite Loop allows the pinging to run until stopped
        count = count + 1
        if Time == 0:  # Each second
            time.sleep(1)
        elif Time == 1:  # Each minute
            time.sleep(60)
        elif Time == 2:  # Each 5 minutes
            time.sleep(300)
        elif Time == 3:  # Run as fast as it can (used to get a lot of values real quick)
            print("")

        currentCosts = getPrices()  # Get the data from a ping

        print(currentCosts)
        AppendToFileCSVDict(currentCosts, title)
        print(count)
        pass

        checkIfDelete(count)
    print("Success")


############################################################################
################################Main Code###################################
############################################################################

Banner()
Main()


