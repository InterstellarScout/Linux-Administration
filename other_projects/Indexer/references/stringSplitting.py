dataName = "Hey"
line = "em.ail@email.com:notPassword"
line = line.split(':')  # index it
first = line[0]  # First = angi20_2201@yahoo.com
second = line[1]  # Second = password#@!1
dataToAppend = dataName + "," + second

firstList = list(first)
if firstList[0] == ".":
    firstList[0] = "'"
if firstList[1] == ".":
    firstList[1] = "'"
if firstList[2] == ".":
    firstList[2] = "'"
if firstList[3] == ".":
    firstList[3] = "'"

first = "".join(firstList)
print(first)