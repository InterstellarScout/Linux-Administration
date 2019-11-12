Rem Get and run file
powershell -Command "Invoke-WebRequest https://go.microsoft.com/fwlink/?LinkId=691209 -OutFile %userprofile%\Downloads\Windows10.exe"
echo Download done. 
echo Upgrading
%userprofile%\Downloads\Windows10.exe /auto upgrade /quiet /copylogs <%userprofile%\Downloads\>
echo Done.
