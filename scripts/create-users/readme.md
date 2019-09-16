This documentation covers how to create users using the scripts provided. The two scripts will allow users to create users on mass given a txt file which contains user name, and a txt file which contains the groups that users will be put in. 

Note: When users are created, a standard password is given. If you want to change this standard password, you need to edit the script and edit the function “getPasswords(nameList).” Change the line “passwordList.append("$ecur3P433W0rd")” and replace “$ecur3P433W0rd” with your own. 

Step 1: Create Users
Script being used: createUsersTxt.py
Within your Linux environment, run the command that you need to run the script. These scripts require python 3, so make sure it has been installed on your system. 
python --version
If the version is anything less than 3.4, please update.  

Run the script:
sudo python createUsersTxt.py

Output:
This program is used to make some users.
The file being imported must be a txt named "users.txt".
Save the file in the directory from which this is being ran.
Would you like to create or delete the users? c/d

Make sure your users.txt file is located in the same directory that you are running the file. Once confirmed, press “c” and hit “enter.”

The script goes through each name, creates a username from those names, then applies a standard password: 
“$ecur3P433W0rd”
Distribute the standard passwords to users. If you want to change it, go back into the script and fix it accordingly as noted above. 

This screen show shows the users being created with the given information.  

The Screenshot below shows that the users have been created:
 
If there are any errors, make sure the name file doesn’t contain any special characters that affect the command line interface. Any extra new lines and /M’s will interfere. 

Step 2: Group Creation
Next Script: putUsersInGroups.py

Run the script:
sudo python putUsersInGroups.py

Output:
This program is used to make some users.
The file being imported must be a txt named "users.txt" and “groups.txt”.
Save the file in the directory from which this is being ran.

The program will then automatically add all users given from the above list to the groups provided.  As you can see in the screenshots below, you will see how it should look.
Users now get applied to a given list of groups. The next script adds them next to this list
 

Confirm that one of the users have been added into their allotted group using the “Groups” Command
groups username

Output:
username : username group
Now we see that the users are in the group using the “Groups” command:
 

With that, congratulations! You have created all of your users. 

