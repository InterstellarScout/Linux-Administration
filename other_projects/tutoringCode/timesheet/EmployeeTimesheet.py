import datetime
print(datetime.datetime.now())


def get_employee(id):
    print(type(id))
    if id == 1234:
        return "Name:Jerry Yang, Employee:1234, Department:Design, Building:(A), Occupation:Manager, Priority:FULL Access"
    elif id == 2345:
        print("no me")
        return "Name:Santo Bobbert, Employee:2345, Department:Design, Building:(A), Occupation:Manager, Priority:FULL Access"
    elif id == 3456:
        print("no me")
        return "Name:Pickles Jr, Employee:3456, Department:Evil, Building:(P), Occupation:Underling, Priority:Forceful Full Access"
    elif id == 4567:
        print("no me")
        return "Name:Robert Bobbert, Employee:4567, Department:Love, Building:(O), Occupation:Skeleton Archer, Priority:No Access"
    elif id == 5678:
        print("no me")
        return "Name:Harry Spotter, Employee:5678, Department:Cute, Building:(X), Occupation:Angry Guy, Priority:Partial Access"
    elif id == 6789:
        print("no me")
        return "Name:Roger Roger, Employee:6789, Department:Angry, Building:(Q), Occupation:Meany Face, Priority:Little Access"
    else:
        print("Employee ID not found")

def log(info, inout):
    currentTime = datetime.datetime.now()
    with open("fname.txt", "a") as file:
        contents = str(currentTime) + " Clocked: " + inout + " " + info
        print(contents)
        file.write(contents + "\n")
        file.close()

    return currentTime

def getTime(id_number,outTime): #get the in and out time from the given ID
    with open("fname.txt", "r") as file:
        #find the in time
        for line in file: #read file bottom up looking for the employee ID and In/Out
            #if line.find("Employee:"+info) and line.find("Clocked: in"): #If the ID number is within string, and the time is "in"
            if "Employee:"+id_number in line and "Clocked: in" in line:
                #get the user's in time
                lineList = line.split(" ")
                inTimeList = lineList[1].split(".")
                finalInTimeList = inTimeList[0].split(":")
                inTime = datetime.time(int(finalInTimeList[0]), int(finalInTimeList[1]), int(finalInTimeList[2]))  #inTime = datetime.time(14, 00, 00)

                #print(outTime)
                outList = str(outTime).split(" ")
                #print(outList)
                outTimeList = outList[1].split(".")
                #print(outTimeList)
                finalOutTimeList = outTimeList[0].split(":")
                #print(finalOutTimeList)
                outTime = datetime.time(int(finalOutTimeList[0]), int(finalOutTimeList[1]), int(finalOutTimeList[2]))  #inTime = datetime.time(14, 00, 00)

                #Do the calculation
                # Create datetime objects for each time (a and b)
                dateTimeA = datetime.datetime.combine(datetime.date.today(), inTime)
                dateTimeB = datetime.datetime.combine(datetime.date.today(), outTime)
                # Get the difference between datetimes (as timedelta)
                dateTimeDifference = dateTimeB - dateTimeA
                # Divide difference in seconds by number of seconds in hour (3600)
                dateTimeDifferenceInHours = dateTimeDifference.total_seconds() / 3600
                print(dateTimeDifferenceInHours)
                break

while True:
    print("A&A Company")
    print("Welcome! ", "Please, Enter Employee ID Number: ")
    id_number = input()

    print("Are you logging in or out?")
    inout = input()

    info = get_employee(int(id_number))
    print(info)

    currentTime = log(info, inout)

    if inout == "out" or inout == "Out":
        getTime(id_number,currentTime)

    print("You're " + inout)