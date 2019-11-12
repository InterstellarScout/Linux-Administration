REM First mount the drive that will be used for the backup
REM net use P: \\DC1\Shared\1Backups 

REM First the Variables
SET DriveLetter=P:
SET BackupLocation=\\DC1\Shared\1Backups
SET NetworkAdmin=mdg
SET NetworkAdminPassword=B@dm0t0rF1ng3r
REM Force the mounting by offering the credentials
net use %DriveLetter% %BackupLocation% /user:%NetworkAdmin% %NetworkAdminPassword%

REM Get Current Date
for /F "tokens=1,2,3 delims=_" %%i in ('PowerShell -Command "& {Get-Date -format "MM_dd_yyyy"}"') do (
    set MONTH=%%i
    set DAY=%%j
    set YEAR=%%k
)

REM Make a folder for this PC's user data to be put.
set SaveDirectory=%computername%-%MONTH%.%DAY%.%YEAR%

REM Delete the folder if it exists. Useful for testing.
REM IF EXIST P:\%SaveDirectory% RMDIR P:\%SaveDirectory%

mkdir %DriveLetter%\%SaveDirectory%

REM Backup the User Libraries
Robocopy C:\Users\ %DriveLetter%\%SaveDirectory% /MIR /XA:SH /XD AppData /XJD /R:5 /W:15 /MT:32 /V /NP /LOG:Backup.log
set message=Copy job completed.
echo %message%
echo %message% >> Backup.log

REM Dismount backup drive
net use P: /Delete
set message=Dismounted.
echo %message%
echo %message% >> Backup.log

REM Reset the variables to something less useful. 
SET DriveLetter=Done.
SET BackupLocation=Done.
SET NetworkAdmin=Done.
SET NetworkAdminPassword=Done.
ECHO Done.