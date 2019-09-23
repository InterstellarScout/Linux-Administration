import binance

def getPrices(): #Returns a dictionary
    currentPriceDictionary = binance.prices()
    #We have a dictionary {'ETHBTC': '0.02198200', 'LTCBTC': '0.00945600'...}
    #print(priceList['ETHBTC'])
    return currentPriceDictionary #A Dictionary

def getFavorites(): #Returns a List of favorites
    '''
    print("What are your favorite coin? The format needed is something converted to something, so BNBBTC or ZECUSDC")
    read answer
    #Delit using the spaces, then make it a list.
    :return:
    '''
    favorites = ["BTCUSDC", "ZECUSDC"] #Add your favorite coins to be printed here.
    return favorites #A List

def printCurrentFavorites(): #Prints the current favorite coins
    current = getPrices()
    favorites = getFavorites()

    for item in favorites:
        print(item + ": " + current[item])

###################################################################################################
##############The###########################Main###############################Code################
###################################################################################################
#Set the keys. binance.set("API Key","Secret")
#binance.set("5GYxIkoBqCQJMzgqZH2sf193FFTVQX52MNVsdNamGpofoFVSm2ftIqyFemvkmQPP", "3t6AkChBnIaDHwzSzdTZUU6m550Q2B3KCBpw8nNpK0giSLSkw2m4loP9NiHkoOXJ")

printCurrentFavorites()