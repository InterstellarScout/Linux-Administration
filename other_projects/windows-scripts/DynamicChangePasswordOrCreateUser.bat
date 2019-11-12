REM This Script is used to change the password of an existing user, or create one if none exists. 
REM Works only on Windows 10

REM First the Variables
REM Desired Username:
SET newUserName=MDGAdmin
SET newPassword=Judg3Jud7L0w

REM First off, lets clean up. If the user mdg exists, delete it. All local admins will be the user you want above. 
REM Assume the user is found unless not
SET userFound=1 
REM Delete mdg... REM If the user is found...
net user | find /i "mdg" || SET userFound=0 
IF %userFound%==1 ( ECHO "found... Deleting." && net user "mdg" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "MDG" || SET userFound=0 
IF %userFound%==1 ( ECHO "found... Deleting." && net user "mdg" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "MDG1" || SET userFound=0 
IF %userFound%==1 ( ECHO "found... Deleting." && net user "mdg1" /delete )

SET userFound=1 
REM Delete MDG... REM If the user is found...
net user | find /i "MDG2" || SET userFound=0 
IF %userFound%==1 ( ECHO "found... Deleting." && net user "mdg2" /delete )

REM Delete MDGAdmin... REM If the user is found...
SET userFound=1 
net user | find /i "MDGAdmin" || SET userFound=0 
IF %userFound%==1 ( ECHO "found... Deleting." && net user "MDGAdmin" /delete )

REM Create the new user with the new password if it isn't found already.
SET userFound=1 

REM Attempt to find the current local admin. If found, the second command will NOT occur.
net user | find /i %newUserName% || SET userFound=0 

REM Change password... If the user is found...
IF %userFound%==1 ( ECHO "found" ) else ( ECHO "not found... Creating." )
REM Change existing user password else create the user.
IF %userFound%==1 ( net user %newUserName% %newPassword% ) else ( net user %newUserName% %newPassword% /add && net localgroup administrators %newUserName% /add )

SET newUserName=Nice Try. 
SET newPassword=Nice Try.
echo Done. 

1.78 extra
.9 Less
