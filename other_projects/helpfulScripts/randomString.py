import random
import string

def randomString(stringLength=20):
    """Generate a random string of fixed length """
    letters = string.ascii_letters
    return ''.join(random.choice(letters) for i in range(stringLength))

for count in range(10):
    print (randomString())
