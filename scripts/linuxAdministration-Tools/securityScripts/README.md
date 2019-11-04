<h3>Objective</h3>

<b>Write a Script to detect ip addresses trying to gain access, examples of things to pay attention to include all use between midnight and 6, all logins for a specific user, anything else you consider behavior that should send up a red flag.</b>
Program Idea: This program logs unusual habbits and logs them into a log every 30 minutes. When a severe action is found, an email is sent to the admin of the server (admin@interstellarlibrary.net)
 
<b>Write script to detect changes to a specific directory.  Such as changes to /var/log or /etc/ think about using a diff here, or a hash.</b>
Program Idea: This program logs

<b>Monitor hidden files, root executables, and see if changes are made, who made them, and when they were changed. </b>
Program Idea: This program logs

<b>Take a snapshot of users every hour (Use a cron job for this) to see if there is any suspicious adding/removing of users</b>
Program Idea: This program logs the MD5 of the passwd file then informs the user if it gets changed. 

<b>Use boot system to control what daemons run on boot.</b>
Program Idea: Create a program that displays the enableable programs. When a user inputs the name of the program they want to enable or disable, it will either stop it from activating on bootup or disable. 

<b>Find out how to boot into emergency mode for both your servers.  Write a one page (or less) document on how to do that. Include 1 paragraph executive summary on why you might want to. </b>
See Documentation

A lot of these would make sense as a cron job, make sure you set up a cron job for at least the snapshot, but feel free to use cron jobs for the rest as well.
Upload all to GitHub including any documentation created.  

Is there anything else you think you should have a script and/or cron job for relating to security?  Write that and submit as well. 