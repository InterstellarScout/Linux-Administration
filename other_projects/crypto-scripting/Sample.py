import csv

def deleteRow():
    with open('test.csv', 'rb') as inp, open('test.csv', 'wb') as out:
        writer = csv.writer(out)
        for row in csv.reader(inp):
            print(row)


my_dict = {'16fr325452342yh': '0', '2dgrs': 'bbb', 'sgrsdg3': 'ccc'}

count = 0
while True:
    print(count)
    with open('test.csv', 'a+') as f:
        for key in my_dict.keys():
            f.write("%s,%s,"%(key,my_dict[key]))
        f.write("\n")
    count = count + 1
    #deleteRows(count)
    if count is 100:
        exit()
