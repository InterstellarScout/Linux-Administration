Purpose:
HaveIBeenPawned tells you whether your email was found in an attack, and their Password module tells you how many times that password has been seen,
but if you want to know what password has been found, you're out of luck. This program allows you to view
the compromised password so you know not to use it again.

This collection contains the lis
Security:
The program will ask for a password to decrypt each file. The decryption will occur when the desired file is located and needed.

Indexing Scheme:
To break down all data and make it faster to parse, the data is broken down by the first three letters of the email address.

If you want to locate abc@email.com, you would go into folder a, the folder b, then open file c
Dir	Dir	File
a-	a	a
b	b-	b
c	c	c-abc@email.com
d	d	d
e	e	e

Included Programs:
index.py - Used to import a file of data and distribute each part of data into their file.

Steps:
1)	First import file - save as a variable, cut into list.
2)	Process List - take each value, take the first three letters to locate the right file, the append that data to the file.
	a) create/navigate directories
	b) create/navigate file
	c) Search the list for the same email address - 
	If found, check id the password is the same - if not, add to list using :
	If not found: append to file w/ newline

find.py - Search for a given email address, and retrieve compromised account information.
1)	Get the email address
2)	Break the password down with the first letters to locate what file it may be located in. 
3)	Pull the file into a variable, convert to list, parse the list for that email address
4)	Optional: Reach out to a resource to get more information on the email holder - this would be a OSINT feature.
5)	If found: Display Results or export
	If not found: Display Results

Future Ideas:
passwords.py - Used to export compromised passwords. These passwords can be salted or compared against so users will
know not to use a discovered password. 
getStats.py - Get a count of compromised accounts, number of times a password has been used, average password legnth, etc. 

Resources:
Person Research - Maybe add to the conjure script. When you look up an email address, you get this information too.
Full Contact:
https://github.com/fullcontact/fullcontact.py?files=1


