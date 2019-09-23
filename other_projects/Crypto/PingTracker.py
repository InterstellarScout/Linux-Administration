#Dean Sheldon
#Network Up/Down Tracker
#Displays current pings and appends them all to a data file.
#Works for sure with Python 3.4
#Works for sure on Windows

import csv #Needed for exporting to csv (easily)
import datetime #Needed for date and time
import platform    # For getting the operating system name
import subprocess  # For executing a shell command
import re #Used for splitting
import time #gives us the sleep function
import os #Allows us to see the PID for process manager.
import sys #Allows us to call python in cmd to use arguments

#############################File Management####################################

def getTitle(Format):
    time = datetime.datetime.now()
    
    print("Type the function of this program. (I.E. Second-Tracking, Minute-Tracking)")
    #answer = input()
    answer = "PingTracking-Seconds-" ####FORCE#####
    
    finalTitle = time.strftime("%Y-%m-%d")
    finalTitle = answer + finalTitle
    
    title = addTxt(finalTitle,Format)
    
    return title

def addTxt(string,option):
    list1 = []
    list1.append(string)
    
    if option == 0: #save as txt
        ext = "txt"
        fullExt = ".txt"
    elif option == 1:
        ext = "csv"
        fullExt = ".csv"
        
    #test if .txt is already in name
    list1 = string.split(".") #replace values with two new values
    list1.append(".")
    print(list1)
    empty = "."
    required = ext
    
    if list1[1] is not required:
        list1[1] = fullExt
        
    if list1[1] is empty:
        list1.append(fullExt)
    
    #print(list1)
    return ''.join(list1)

def CreateCSVFileForAppending(title): #returns the file
    #Erases any existing file with the new data
    with open(title, mode='w+') as dataFile:
        dataFile = csv.writer(dataFile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        dataFile.writerow(['Date', 'Time', 'IP Address', 'Bytes', 'Travel Time (ms)', 'TTL'])
    return dataFile

def CreateTXTFileForAppending(title): #returns the file
    #Open file
    #file = open(title,"a+")
    with open(title, mode='w+') as dataFile:
        dataFile.write('Date Time IP-Address Bytes Travel-Time(ms) TTL\n')
    return dataFile

###########################Add Data to File##################################
    
def AppendToFile(stringToSave,file):
#Write lines in the data file.
    for i in range(2):
        file.write("Appended line %d\r\n" % (i+1))
    #file.write(string)

    print("Saved")
        
def AppendToFileCSV(listToSave,title):
    print(listToSave)
    with open(title, mode='a+') as dataFile:
        dataFile = csv.writer(dataFile, delimiter=',', quotechar='"', quoting=csv.QUOTE_MINIMAL)
        #Write lines in the data file.
        for i in range(2):
            #Date,Time,IP_Address,Byes,Time,TTL   
            dataFile.writerow([listToSave[0], listToSave[1], listToSave[2], listToSave[3], listToSave[4], listToSave[5]])
            
    print("Saved")
        

###############################Get Data#####################################
    
def pingV1(host,count):
    # Ping parameters as function of OS
    param = '-n' if platform.system().lower()=='windows' else '-c'
    command = "ping " + " " + param + " " + str(count) + " " + host
    
    need_sh = False if  platform.system().lower()=="windows" else True
    
    ping = subprocess.Popen(command, need_sh, stdout=subprocess.PIPE).stdout.read()
    
    ping = ping.decode("utf-8") #bytes to string
    
    return ping


############################Process Data####################################

def splitPingString(string): #takes a string in and returns the data that I want to keep
    #Variables#
    time = datetime.datetime.now()
    date = time.strftime("%Y-%m-%d")
    time = time.strftime("%H:%M:%S")
    finalList = []
        
    infoList = re.split(r'[\n\r]+',string) #Split the list
    
    for item in infoList: #Remove any unneeded list inputs like spaces or empty spots
        if item == '':
            infoList.remove(item) #Remove any unneeded data.
        if item == '\n':
            infoList.remove(item) #Remove any unneeded data.
        if item == '\s':
            infoList.remove(item) #Remove any unneeded data.
        if "bytes" in item:
            finalList.append(item) #Take the only line I want        
        if "unreachable" in item or "out" in item: #If the destination was unreachale, return NULL
            return [date,time,"Unreachable","NULL","NULL",128]
        
    finalList = ''.join(finalList) #Make our needed data a string
    print(finalList)
    #FinalFormat - Date,Time,IP_Address,Byes,Time,TTL   
    if platform.system().lower()=='windows':
        #Windows: Reply from 192.168.62.2: bytes=32 time=3ms TTL=128
        #print("Exporting as Windows.")
        infoList = re.split(r'[\s=]+',finalList)
        IP_Address = infoList[2][:-1]
        Bytes = infoList[4]
        TravelTime = []
        for s in infoList[6]:
            if s.isdigit():
                TravelTime.append(s)
                #print(s)
        TravelTime = ''.join(TravelTime)
        TTL = infoList[8]
        FinalFormat = [date,time,IP_Address,Bytes,TravelTime,TTL]
    else:
        #Linux: 64 bytes from 192.168.62.2: icmp_seq=3 ttl=128 time=3.31 ms
        #print("Exporting as Linux.")
        infoList = re.split(r'[\s=]+',finalList)
        IP_Address = infoList[3][:-1]
        Bytes = infoList[0]
        TravelTime = infoList[9]
        TTL = infoList[7]
        FinalFormat = [date,time,IP_Address,Bytes,TravelTime,TTL]
    
    return FinalFormat

############################################################################

def StartingFunction(Format,title): #This function is dedicated to tasks that run once
    print("This program is used to ping something.")
    print("Process ID:", os.getpid())
    
    #FinalFormat - Date,Time,IP_Address,Byes,Time,TTL
    if Format == 0: #Save as txgt
        workingFile = CreateTXTFileForAppending(title) #Open the file to be appended to
    elif Format == 1: #Save as csv
        workingFile = CreateCSVFileForAppending(title) #Open the file to be appended to
    
def Banner():
    print("|=================================|")
    print("|             Pinger              |")
    print("|=================================|\n")
    
def Main():
    ##################FORCES#####################
    Format = 1 #0 to save as txt, 1 to save as csv
    Time = 0 #Set the time: 0 for 1 second, 1 for 60 seconds, 2 for 5 minutes
    Host = "8.8.8.8" #This variable is what is being pinged
    ###################END FORCES################
    print("Welcome to Pinger!")
    print("Please enter the arguments below with the format:")
    print("<Output Type> <Time> <Host Destination>\n")
    
    print("Would you like to save as .txt (0) or .csv (1)?")
    print("Would you like to Set the time: (0) for 1 second, (1) for 60 seconds, or (2) for 5 minutes")
    print("What is your destination host? IPv4 only: ###.###.###.###")
#    answer = input() #Take in the inputs - 1 0 192.168.62.2
#    answer = re.split(r'[\s]+',answer)
#    Format = int(answer[0])
#    Time = int(answer[1])
#    Host = str(answer[2])
    
#    print(answer)
    print("Perfect. This program will run contiously. To stop, press CTRL-C or Z, depending on your system.")
    title = getTitle(Format) #The tile of the working file
    print("The file is saving as", title)
    StartingFunction(Format,title)
    
    count = 0
    while True: #Infinite Loop allows the pinging to run until stopped
        count = count + 1
        if Time == 0: #Each second
            time.sleep(1)
        elif Time == 1: #Each minute
            time.sleep(60)
        elif Time == 2: #Each 5 minutes
            time.sleep(300)
        elif Time == 3: #Run as fast as it can (used to get a lot of values real quick)
            print("")
            
        ping = pingV1(Host,1) #Get the data from a ping

        print(ping)
        ping = splitPingString(ping)
        AppendToFileCSV(ping, title)
        print(count)
        pass

    print("Success")

############################################################################
################################Main Code###################################
############################################################################

Banner()
Main()


