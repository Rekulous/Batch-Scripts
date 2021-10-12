@rem ----[ This code block detects if the script is being running with admin PRIVILEGES If it isn't it pauses and then quits]-------
echo OFF
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
    ECHO.
) ELSE (
   echo ######## ########  ########   #######  ########  
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ##       ##     ## ##     ## ##     ## ##     ## 
   echo ######   ########  ########  ##     ## ########  
   echo ##       ##   ##   ##   ##   ##     ## ##   ##   
   echo ##       ##    ##  ##    ##  ##     ## ##    ##  
   echo ######## ##     ## ##     ##  #######  ##     ## 
   echo.
   echo.
   echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   echo This script must be run as administrator to work properly!  
   echo If you're seeing this after running this script, then right click on the shortcut and select "Run As Administrator".
   echo ##########################################################
   echo.
   PAUSE
   EXIT /B 1
)
:begin
:: Is this a developer machine?
set /p choco="Is chocolatey installed? (y - Yes, n - No): "
IF /i "%choco%" == "y" GOTO continue
IF /i "%choco%" == "n" GOTO install
ECHO "Invalid option"
GOTO begin
:install
:: Install Chocolatey package manager
@powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
 
:continue
:: NORMAL APPLICATIONS (INSTALL FIRST)
:: PC Frameworks
choco install dotnet4.5 -y
choco install vcredist2008 -y
choco install vcredist2010 -y
choco install vcredist2012 -y
choco install vcredist2013 -y
choco install dotnet4.5.1 -y
 
:: Java
choco install javaruntime -y
choco install jre8 -y
choco install jdk8 -y
 
:: Browsers
choco install googlechrome -y
choco install opera -y
choco install firefox -y
 
:: Essentials
choco install 7zip -y
choco install flashplayerplugin -y
choco install flashplayeractivex -y
choco install adobereader -y
choco install ccleaner -y
 
:: DEVELOPMENT APPLICATIONS
:: Development Software/Frameworks
choco install nodejs -y
choco install winmerge -y
choco install fiddler4 -y
choco install filezilla -y
choco install rdcman -y
choco install putty -y
choco install python -y
 
:: File Editors
choco install sublimetext3 -y
choco install notepadplusplus -y
 
:: Graphics Editor
choco install paint.net -y
  
:: End of software installation
:end