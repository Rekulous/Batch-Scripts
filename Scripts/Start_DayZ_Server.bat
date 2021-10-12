@echo off
TITLE DayZ SA Server - Status
COLOR 0A
    :: DEFINE the following variables where applicable to your install
    SET SteamLogin=AccountUsername AccountPassword
    SET DayZBranch=223350
    SET DayZServerPath="C:\Servers\DayZ"
    SET SteamCMDPath="C:\Servers\SteamCMD"
    SET BECPath="C:\Servers\BEC"
    :: _______________________________________________________________
 
goto checkServer
pause
 
:checkServer
tasklist /fi "imagename eq DayZServer_x64.exe" 2>NUL | find /i /n "DayZServer_x64.exe">NUL
if "%ERRORLEVEL%"=="0" goto checkBEC
cls
echo Server is not running, taking care of it..
goto killServer
 
:checkBEC
tasklist /fi "imagename eq BEC.exe" 2>NUL | find /i /n "BEC.exe">NUL
if "%ERRORLEVEL%"=="0" goto loopServer
cls
echo Bec is not running, taking care of it..
goto startBEC
 
:loopServer
FOR /L %%s IN (30,-1,0) DO (
    cls
    echo Server is running. Checking again in %%s seconds.. 
    timeout 1 >nul
)
goto checkServer
 
:killServer
taskkill /f /im Bec.exe
taskkill /f /im DayZServer_x64.exe
goto updateServer
 
:updateServer
cls
echo Updating DayZ SA Server.
timeout 1 >nul
cls
echo Updating DayZ SA Server..
timeout 1 >nul
cls
echo Updating DayZ SA Server...
cd "%SteamCMDPath%"
start /wait steamcmd.exe +login %SteamLogin% +force_install_dir %DayZServerPath% +"app_update %DayZBranch%" +quit
goto startServer
 
:startServer
cls
echo Starting DayZ SA Server.
timeout 1 >nul
cls
echo Starting DayZ SA Server..
timeout 1 >nul
cls
echo Starting DayZ SA Server...
cd "%DayZServerPath%"
start DayZServer_x64.exe -instanceId=1 -config=serverDZ.cfg -profiles=ServerName -port=2302 -cpuCount=8 -noFilePatching -dologs -adminlog -freezecheck
FOR /l %%s IN (45,-1,0) DO (
    cls
    echo Initializing server, wait %%s seconds to initialize BEC.. 
    timeout 1 >nul
)
goto startBEC
 
:startBEC
cls
echo Starting BEC.
timeout 1 >nul
cls
echo Starting BEC..
timeout 1 >nul
cls
echo Starting BEC...
timeout 1 >nul
cd "%BECPath%"
start Bec.exe -f Config.cfg --dsc
goto checkServer