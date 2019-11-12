REM Restore User Library
REM First mount the drive that contains the backed up files
net use P: \\DC1\Shared\1Backups 

REM Get the computer's name so we know what PC backup to use.
set SaveDirectory=%computername%
REM set SaveDirectory=Pickel

REM For each folder in the directory, do this when the computer name is found. 
for /f "tokens=*" %%G in ('dir /b /s /a:d "P:\%computername%*"') do (
echo Found %%G
Robocopy /xo /xc /xn %%G C:\Users /MIR /XA:SH /XJD /R:5 /W:15 /MT:32 /V /NP /LOG:%computername%.Restore.log
)

REM mkdir P:\%SaveDirectory%


REM Dismount backup drive
net use P: /Delete