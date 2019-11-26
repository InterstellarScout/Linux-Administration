import datetime
print(datetime.datetime.now())

with open("fname.txt", "r") as file:
    inTime = datetime.time(14, 00, 00)
    # find the in time
    for line in reversed(file):  # read file bottom up looking for the employee ID and In/Out
        if line.find("Employee:"+info) and line.find("Clocked: in"):  # If the ID number is within string, and the time is "in"
            # get the user's in time
            print("Found the user's login")