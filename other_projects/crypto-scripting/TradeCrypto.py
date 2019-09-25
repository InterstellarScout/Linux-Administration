'''
Script Created by Dean Sheldon
Works with Python 3
This script is good on any linux distribution that works with Python 3 and has an active internet connection.
It is used for Buying/Selling/Viewing crypto in your Binance Account
The creator of this script is not responsible for any financal gains or losses that you may make using this script.
You are sole responsible for the actions that come from your actions.
'''

import binance
from datetime import datetime
import sys
import time

def getPrices(): #Returns a dictionary
    currentPriceDictionary = binance.prices()
    #We have a dictionary {'ETHBTC': '0.02198200', 'LTCBTC': '0.00945600'...}
    #print(priceList['ETHBTC'])
    return currentPriceDictionary #A Dictionary

def setExchangeFavorites():
    '''
    print("What are your favorite coin? The format needed is something converted to something, so BNBBTC or ZECUSDC")
    read answer
    #Delit using the spaces, then make it a list.
    favorites = list(answer.split(" "))
    return favorites
    '''
    favorites = ["BTCUSDC", "ZECUSDC", "NPXSBTC"] #Add your favorite coins to be printed here.
    verifyInput(favorites)
    return favorites #A List

def setFavoriteCoins():
    '''
    print("What are your favorite coin? The format needed is something converted to something, so BTC or ZEC")
    read answer
    #Delit using the spaces, then make it a list.
    favorites = list(answer.split(" "))
    return favorites

    '''
    favorites = ["BTC", "ZEC", "NPXS", "USDC"] #Add your favorite coins to be printed here.
    return favorites #A List


def clear():
    sys.stdout.write("\033[2J")  # Erase everything

def verifyInput(favorites):
    current = getPrices()
    try:
        for item in favorites:
            verified = current[item]
            print(item + " looks good at " + verified)

    except:
        print("ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR")
        print("ERROR ERROR ERROR: A value you entered does not match the format of any existing currency:ERROR ERROR ERROR")
        print("ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR ERROR")
        print(item + " has been input incorrectly.")
        print("Exiting program.")
        exit()
    print("Your favorites have been set.")
    print("Pres Enter to continue...")
    trash = input()
    sys.stdout.write("\033[2J")  # Erase everything

def printCurrentFavorites(): #Prints the current favorite coins
    current = getPrices()
    favorites = setExchangeFavorites()

    for item in favorites:
        print(item + ": " + current[item])
    time.sleep(1)

def printToScreen(currentItem,run,favSize):
    count = 0
    favSize = favSize - 1
    #favSize = favSize+1 #Add one to include the Time Update
    if run is not favSize:
        sys.stdout.write("\r{0}\n".format(currentItem))
    else:
        sys.stdout.write("\r{0}".format(currentItem))

        '''sys.stdout.write("\033[{0}A".format(favSize))'''
        ''''#while count > favSize: #Go back to the top where everything started
        sys.stdout.write("\033[1A")
        count = count + 1
        '''

def getDateTime():
    while True:
        now = datetime.now()  # Get the date and time
        dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
        print("date and time =", dt_string)
        time.sleep(1)

def checkBalances(ExchangeFavorites,CoinFavorites,destination):
    print("Lets check the balances:")
    now = datetime.now()  # Get the date and time
    theTime = now.strftime("%d/%m/%Y %H:%M:%S")
    current = "Deleted"  # Erase the previous entry
    current = binance.balances() #Returns a dictionary full of all coins.
    favSize = len(CoinFavorites)

    UpdateTime = "\nUpdate: " + theTime + "\n"
    print(UpdateTime)

    for count, item in enumerate(CoinFavorites):
    #"item" This is a favorited coin. It is a dictionary for free and locked amounts. A dictionary of a dictionary.
        currentItem = item + " available: " + current[item]['free']
        currentItem = currentItem + " \n" + item + " locked: " + current[item]['locked']
        total = float(current[item]['free']) + float(current[item]['locked'])
        currentItem = currentItem + " \nTotal Owned: " + str(total) + " " + item + "\n"
        printToScreen(currentItem, count, favSize)
        sys.stdout.flush()

    if destination is 1:
        return
    else:
        print("\n\nPress Enter to continue...")
        input()
        fullMenu(ExchangeFavorites,CoinFavorites)

def openOrders(ExchangeFavorites,CoinFavorites,destination): #Requires Echange Favs
    favSize = len(ExchangeFavorites)
    now = datetime.now()  # Get the date and time
    theTime = now.strftime("%d/%m/%Y %H:%M:%S")
    UpdateTime = "\nUpdate: " + theTime + "\n"
    print("Displaying all Open Orders:")
    print(UpdateTime)

    for count, item in enumerate(ExchangeFavorites):  # Item is the current echangetoken Ex. BTCUSDC
        currentItem = binance.openOrders(item)  # Returns a dictionary for current item
        print(item + ":")  # Show the currency being shown
        print("===================================================\n")
        for count, order in enumerate(currentItem):  # Sift through the list of dictionaries and show unique order ID's
            readableTime = time.ctime(order['time'] / 1000)
            currentOrder = "Time:" + readableTime + " Order ID:" + str(order['orderId']) + " Action:" + str(
                order['side']) + "\nPrice:" + str(order['price']) + " Amount:" + str(
                order['origQty']) + "\nStatus:" + str(order['status']) + "\n"
            if str(order['status']) != "CANCELED":  # Ignore canceled orders
                printToScreen(currentOrder, count, favSize)
        sys.stdout.flush()
    if destination is 1: #Go to previous function
        return 0
    else: #Go back home
        print("Press Enter to continue...")
        input()
        fullMenu(ExchangeFavorites, CoinFavorites)

def allOrders(ExchangeFavorites,CoinFavorites):
    favSize = len(ExchangeFavorites)
    now = datetime.now()  # Get the date and time
    theTime = now.strftime("%d/%m/%Y %H:%M:%S")
    UpdateTime = "\nUpdate: " + theTime + "\n"
    print("Displaying all Orders:")
    print(UpdateTime)

    for count, item in enumerate(ExchangeFavorites): #Item is the current echangetoken Ex. BTCUSDC
        currentItem = binance.allOrders(item) #Returns a dictionary for current item
        print(item + ":") #Show the currency being shown
        print("===================================================\n")
        for count, order in enumerate(currentItem): #Sift through the list of dictionaries and show unique order ID's
            readableTime = str(order['time']) #time.ctime(order['time']/1000)
            currentOrder = "Time:" + readableTime + " Order ID:" + str(order['orderId']) + " Action:" + str(order['side']) + "\nPrice:" + str(order['price']) + " Amount:" + str(order['origQty']) + "\nStatus:" + str(order['status']) + "\n"
            if str(order['status']) != "CANCELED": #Ignore canceled orders
                printToScreen(currentOrder, count, favSize)
        sys.stdout.flush()
    print("Press Enter to continue...")
    input()
    fullMenu(ExchangeFavorites,CoinFavorites)

def printCurrentFavorites(ExchangeFavorites,CoinFavorites,goTo): #Prints the current favorite coins with their price
    while True:
        try:
            clear()
            now = datetime.now() #Get the date and time
            theTime = now.strftime("%d/%m/%Y %H:%M:%S")
            current = "Deleted" #Erase the previous entry
            current = getPrices() #Get the current Prices. Binance returns all coins avaiable.
            favSize = len(ExchangeFavorites)

            UpdateTime = "\nUpdate: " + theTime + "\n"
            print(UpdateTime)

            for count, item in enumerate(ExchangeFavorites):
                currentItem = item + ": " + current[item]
                printToScreen(currentItem,count,favSize)
                sys.stdout.flush()
            time.sleep(2)
        except:
            print("Going to main menu:")
            if goTo is "limited":
                limitedMenu(ExchangeFavorites)
            elif goTo is '1':
                return
            else:
                fullMenu(ExchangeFavorites,CoinFavorites)

def printCurrentFavoriteOnce(ExchangeFavorites,CoinFavorites): #Prints the current favorite coins with their price
    try:
        now = datetime.now() #Get the date and time
        theTime = now.strftime("%d/%m/%Y %H:%M:%S")
        current = getPrices() #Get the current Prices. Binance returns all coins avaiable.
        favSize = len(ExchangeFavorites)

        UpdateTime = "\nUpdate: " + theTime + "\n"
        print(UpdateTime)

        for count, item in enumerate(ExchangeFavorites):
            currentItem = item + ": " + current[item]
            printToScreen(currentItem,count,favSize)
            sys.stdout.flush()
    except:
        print("Could not get current prices.")
        print("Error in: printCurrentFavoriteOnce()")

def getAPI():
    #Input your API keys here.
    # Set the keys. binance.set("API Key","Secret")
    APIKey = "UXrKsrFcPkw2dfZ9EqPsNllceRpFSipHJnzFhO4Td9dk6HoiFdrDUAKmpaDkjry3"
    APISecret = "L2io7IRwFj5A2DDfp9Z8Bpw37wDX7iZXo2oC1l0dEr8IrEgSq9GzlOAXQaUTcecE"

    #APIKey = "INPUT_KEY_HERE"
    #APISecret = "INPUT_SECRET_HERE"

    if APIKey is "INPUT_KEY_HERE" or APISecret is "INPUT_SECRET_HERE":
        print("WARNING: You did not input your API keys. All this program can do for you is show you current prices")
        return 0

    #binance.set("UXrKsrFcPkw2dfZ9EqPsNllceRpFSipHJnzFhO4Td9dk6HoiFdrDUAKmpaDkjry3", "L2io7IRwFj5A2DDfp9Z8Bpw37wDX7iZXo2oC1l0dEr8IrEgSq9GzlOAXQaUTcecE")
    binance.set(APIKey, APISecret)
    print("Your keys are all set.")
    return 1

def createOrder(ExchangeFavorites, CoinFavorites):
    print("Lets place an order:")
    print("Open Orders:")
    openOrders(ExchangeFavorites, CoinFavorites, 1)

    print("Current Balances:")
    checkBalances(ExchangeFavorites, CoinFavorites, 1)

    FavList = "\nYour favorite Exchanges:"
    for item in ExchangeFavorites:
        FavList = FavList + " " + item + " "
    print(FavList)

    print("Please enter the coin exchange you are making an order for, the value of the coin, and the amount you are buying.")
    print("Ex. \"BTCUSDC Buy 11713 0.020189\" or \"NPXSBTC Sell 9990 0.00000012\"")
    answer = input()
    answers = answer.split()
    try:
        if answers[1] in ["Buy", "buy," "b", "B"]:
            print("Buying")
            binance.order(answers[0], binance.BUY, answers[2], answers[3])
        elif answers[1] in ["Sell", "sell," "s", "S"]:
            print("Selling")
            binance.order(answers[0], binance.SELL, answers[2], answers[3])
        elif answers[0] is "e":
            fullMenu(ExchangeFavorites, CoinFavorites)
            print(answers[1])
            #Print current balance and current price
        print("Success.")
        time.sleep(1)
    except:
        print("Something went wrong. Check your numbers.")
    fullMenu(ExchangeFavorites, CoinFavorites)

def cancelOrder(ExchangeFavorites, CoinFavorites):
    print("Lets cancel an order:")
    openOrders(ExchangeFavorites, CoinFavorites,1)
    print("Input the exchange and order ID (Ex. \"BTCUSDC 12345678\")")
    answer = input()
    answers = answer.split()
    try:
        binance.cancel(answers[0], orderId=answers[1])
        print("Success.")
        time.sleep(1)
    except:
        print("Something went wrong. Check your spelling.")
    fullMenu(ExchangeFavorites,CoinFavorites)

def Banner():
    sys.stdout.write("\033[2J") #Erase everything
    print("###################################################")
    print("###########Crypto Trader for Binance###############")
    print("###################################################")
    print("Welcome to Crypto Trader for Binance.")
    print("The creator of this script is not responsible for ")
    print("the stupid things you can do with this.")
    print("Be smart with your money.")
    print("Press Enter to continue...")
    input()
    sys.stdout.write("\033[2J")  # Erase everything

def limitedMenu(ExchangeFavorites):
    sys.stdout.write("\033[2J") #Erase everything
    print("Welcome to the Main Menu.")
    print("What would you like to do?")
    print("Input \"P\" to get current prices for your favorites.")
    print("Input \"e\" to end the program.")
    answer = input()
    if answer is "P" or answer is "p":
        sys.stdout.write("\033[2J")  # Erase everything
        printCurrentFavorites(ExchangeFavorites,"limited")
    elif answer is "k" or answer is "K":  # Look at open and closes on currencies in the last minute.
        binance.klines("BNBBTC", "1m")
    elif answer is "e" or answer is "exit":
        exit()
    else:
        print("You input something funky. Please try again.\n\n")
        limitedMenu(ExchangeFavorites)

def fullMenu(ExchangeFavorites,CoinFavorites):
    sys.stdout.write("\033[2J") #Erase everything
    print("            Welcome to the Main Menu.")
    print("          What would you like to do?\n")
    print("===================================================")
    print("================  Order Creation  =================")
    print("Input \"p\" to get current prices for your favorites.")
    print("Input \"b\" to check coin balances on your account.")
    print("")
    print("================  Order Creation  =================")
    print("         Input \"o\" to place an order.         ")
    print("         Input \"c\" to cancel an order.        ")
    print("")
    print("==================  View Orders  ==================")
    print("      Input \"s\" to view open order status.    ")
    print(" Input \"a\" to view all orders open or closed. ")
    print("")
    print("==================  End Program  ==================")
    print("         Input \"e\" to end the program.        ")
    print("===================================================")
    answer = input()

    #Done
    if answer is "P" or answer is "p": #Look at Current Prices
        sys.stdout.write("\033[2J")  # Erase everything
        printCurrentFavorites(ExchangeFavorites,CoinFavorites,"full")

    #Done
    elif answer is "b" or answer is "B":  # Look at Current Balances on account
        clear()
        checkBalances(ExchangeFavorites,CoinFavorites,0)

    elif answer is "o" or answer is "O":  # Place an order. Make sure this pulls up enough data for the user to know what they're doing.
        clear()
        createOrder(ExchangeFavorites, CoinFavorites)

    elif answer is "c" or answer is "C": #Cancel and order. Make sure to show current orders.
        clear()
        cancelOrder(ExchangeFavorites,CoinFavorites)

    elif answer is "s" or answer is "S":  # View open orders. This command must be run for each currency.
        clear()
        openOrders(ExchangeFavorites,CoinFavorites,0)

    elif answer is "a" or answer is "A": #View all orders open or closed. Must run for each currency.
        clear()
        allOrders(ExchangeFavorites,CoinFavorites)

    elif answer is "e" or answer is "exit": #Exit
        clear()
        exit()
    else:
        print("You input something funky. Please try again.\n\n")
        fullMenu(ExchangeFavorites,CoinFavorites)

###################################################################################################
##############The###########################Main###############################Code################
###################################################################################################

Banner() #Print Banner
avaiableFeatures = getAPI() #Set API for the program.
ExchangeFavorites = setExchangeFavorites()
CoinFavorites = setFavoriteCoins()

if avaiableFeatures is 0: #If the user does not have API Keys
    limitedMenu(ExchangeFavorites)

else: #If the user has API Keys
    fullMenu(ExchangeFavorites,CoinFavorites)
