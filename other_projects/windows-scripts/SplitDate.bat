for /F "tokens=1,2,3 delims=_" %%i in ('PowerShell -Command "& {Get-Date -format "MM_dd_yyyy"}"') do (
    set MONTH=%%i
    set DAY=%%j
    set YEAR=%%k
)
echo %MONTH% %DAY% %YEAR%