import datetime
print(datetime.datetime.now())


def get_employee(id):
    print(type(id))
    if id == 1234:
        print("im running")
        return "Name:Jerry Yang, Employee:1234, Department:Design, Building:(A), Occupation:Manager, Priority:FULL Access"
    elif id == 2345:
        print("no me")
        return "Name:Santo Bobbert, Employee:1234, Department:Design, Building:(A), Occupation:Manager, Priority:FULL Access"
    else:
        print("not working")

def log(info, inout):
    with open("fname.txt", "a") as file:
        contents = str(datetime.datetime.now()) + " Clocked: " + inout + " " + info
        print(contents)
        file.write(contents + "\n")
        file.close()

def getTime(): #get the in and out time from the given ID
    with open("fname.txt", "r") as file:
        inTime = datetime.time(14, 00, 00)
        #find the in time
        for line in reversed(file):
            print("read file bottom up looking for the employee ID and In/Out")

        outTime = datetime.time(22, 00, 00)
        #find the out time

        #Do the calculation
        # Create datetime objects for each time (a and b)
        dateTimeA = datetime.datetime.combine(datetime.date.today(), inTime)
        dateTimeB = datetime.datetime.combine(datetime.date.today(), outTime)
        # Get the difference between datetimes (as timedelta)
        dateTimeDifference = dateTimeB - dateTimeA
        # Divide difference in seconds by number of seconds in hour (3600)
        dateTimeDifferenceInHours = dateTimeDifference.total_seconds() / 3600
        print(dateTimeDifferenceInHours)

# inTime = datetime.time(14,00,00)
# outTime = datetime.time(22,00,00)
# # Create datetime objects for each time (a and b)
# dateTimeA = datetime.datetime.combine(datetime.date.today(), inTime)
# dateTimeB = datetime.datetime.combine(datetime.date.today(), outTime)
# # Get the difference between datetimes (as timedelta)
# dateTimeDifference = dateTimeB - dateTimeA
# # Divide difference in seconds by number of seconds in hour (3600)
# dateTimeDifferenceInHours = dateTimeDifference.total_seconds() / 3600
# print(dateTimeDifferenceInHours)

print("A&A Company")
print("Welcome! ", "Please, Enter Employee ID Number: ")
id_number = input()

print("Are you logging in or out?")
inout = input()

info = get_employee(int(id_number))
print(info)

log(info, inout)

if inout == "out":
    getTime(info)

print("You're " + inout)