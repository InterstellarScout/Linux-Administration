#Run this script to change the message of the day.
#Edit the Function "StaticMessage" to change what doesn't change.
#Future ideas are Display IP Address - Quote - Jokes
#Dean Sheldon
import datetime
import os
import random
import subprocess #needed to get input from console

def staticMessage():
    x = datetime.datetime.now()

    #message = str(x.strftime("%B %d %Y %I:%M:%S %p")) + "\nWelcome to Dean's Server.\nRemember, if you are not authorized to have access, you will be hunted down and tickled. \nNo Homo."
    message = str(x.strftime("%B %d %Y %I:%M:%S %p")) + "\nWelcome to NECC's CIS Server.\n"

    return message

def getFile(fileName):
    print("Opening File:")
    try:
        file = open(fileName, "r")
        #file = open(fileName, encoding="utf8")
        contents = file.read()
        #print(contents)
        contents = contents.split('\n') #make a list consisting of the rows

        file.close()
        return contents

    except:
        try:
            #file = open(fileName, "r")
            file = open(fileName, encoding="utf8")
            contents = file.read()
            # print(contents)
            contents = contents.split('\n')  # make a list consisting of the rows

            file.close()
            return contents
        except:
            print("Option 2 failed too...")
        print("Something went wrong! Please Check your file. ")
        exit()

def chooseMessage(allMessages):
    listLen = len(allMessages)
    message = allMessages[random.randint(0, listLen)]

    print(message)
    return message

def getIP():
    #out = subprocess.Popen(['ipconfig'],
    out = subprocess.Popen(['hostname', '-I'],
                           stdout=subprocess.PIPE,
                           stderr=subprocess.STDOUT)
    stdout, stderr = out.communicate()
    return str(stdout)

    ####################################################################
    ############################   MAIN   ##############################
    ####################################################################
ipInfo = "Your IP address is: " + getIP()
allMessages = getFile("inspirationalQuotes.txt")
#allMessages = getFile("jokes.txt")

message = staticMessage() #Get the standard message
print(message)
message = message + "\n" + ipInfo + "\n" + chooseMessage(allMessages) + "\n"
print(message)

#Create a file that will become MOTD
f = open("motd", "w")
f.write(message)
f.close()

#Apply the Change to MOTD
os.system("sudo rm /etc/motd") #delete the current motd
os.system("sudo mv motd /etc/") #move the new motd to /etc/
os.system("sudo chmod 644 /etc/motd") #update permissions
os.system("sudo chown root:root /etc/motd") #update owner


