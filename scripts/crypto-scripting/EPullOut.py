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
    favorites = "BTCUSDC" #Add your favorite coins to be printed here.
    return favorites #A String

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
##############################View Orders################################################

def getRecentOrder(ExchangeFavorites):
    favSize = len(ExchangeFavorites)
    now = datetime.now()  # Get the date and time
    theTime = now.strftime("%d/%m/%Y %H:%M:%S")
    UpdateTime = "\nUpdate: " + theTime + "\n"
    print("Displaying all Orders:")
    print(UpdateTime)

    #Item is the current echangetoken Ex. BTCUSDC
    lastOrderTime = 0
    currentItem = binance.allOrders(ExchangeFavorites) #Returns a dictionary for current item
    print(ExchangeFavorites + ":") #Show the currency being shown
    print("===================================================\n")

    for count, order in enumerate(currentItem): #Sift through the list of dictionaries and show unique order ID's
        #recentOrderTime = time.ctime(order['time']/1000)
        print(order['time'])
        recentOrderTime = int(order['time'])
        if str(order['status']) != "CANCELED":  # Ignore canceled orders
            if recentOrderTime > lastOrderTime: #check if the current order is greater than the last
                lastOrderTime = recentOrderTime #the last one is now the current one
                recentOrder = order #The most recent order is applied

    StrRecentOrder = "Time:" + str(lastOrderTime) + " Order ID:" + str(recentOrder['orderId']) + " Action:" + str(recentOrder['side']) + "\nPrice:" + str(recentOrder['price']) + " Amount:" + str(recentOrder['origQty']) + "\nStatus:" + str(recentOrder['status']) + "\n"
    print(StrRecentOrder)
    print(recentOrder)
    if str(order['side']) != "SELL":
        print("Waiting")
        return {'symbol': 'WAIT'}
        #It needs to wait until there is a buy.
    else:
        return recentOrder #Returns Dictionary {'symbol': 'BTCUSDC', 'orderId': 64749613, 'clientOrderId': 'pc_8b127a25cb44440d9250373e0940810c', 'price': '10800.00000000', 'origQty': '0.00560000', 'executedQty': '0.00560000', 'cummulativeQuoteQty': '60.48000000', 'status': 'FILLED', 'timeInForce': 'GTC', 'type': 'LIMIT', 'side': 'BUY', 'stopPrice': '0.00000000', 'icebergQty': '0.00000000', 'time': 1564838510099, 'updateTime': 1564839150393, 'isWorking': True}

##############################Order Creation#############################################

def createOrder(ExchangeFavorites, buySell, order):
    print("Lets place an order:")
    print("Please enter the coin exchange you are making an order for, the value of the coin, and the amount you are buying.")
    print("Ex. \"BTCUSDC Buy 11713 0.020189\" or \"NPXSBTC Sell 9990 0.00000012\"")
    if buySell is 0: #Buy if 0
        print("Buying")
        binance.order(ExchangeFavorites, binance.BUY, order['origQty'], order['price'])
    elif buySell is 1: #Sell if 0
        print("Selling")
        binance.order(ExchangeFavorites, binance.SELL, order['origQty'], order['price'])
    else:
        print("Something ain't right.")
        exit()
    #Print current balance and current price
    print("Success.")
    time.sleep(1)

def cancelOrder(ExchangeFavorites, orderID):
    print("Lets cancel an order:")
    print("Canceling order: " + orderID + " in " + ExchangeFavorites)

    binance.cancel(ExchangeFavorites, orderId=orderID)
    print("Success.")
    time.sleep(1)

def checkPrice(ExchangeFavorites):  # Prints the current favorite coin with their price
    current = getPrices()  # Get the current Prices. Binance returns all coins avaiable.
    #print(current)
    price = current[ExchangeFavorites] #Get the price for the item
    return price #Return the current price

###################################################################################################
##############The###########################Main###############################Code################
###################################################################################################
getAPI()
print("This is the \"OH SHIT\" Pullout method.")
print("Use this if you want insurance that your crypto currency to stay above a certain thresh hold.")
print("Note: This program is only built to pull out. Only use it if you need to.")
#Get the ONE currency we are following.
Favorite = setExchangeFavorites()

#Get the most recent buy. If there is a sell for the same currency, wait for a buy.
currentOrder = getRecentOrder(Favorite)
print(checkPrice(Favorite))
