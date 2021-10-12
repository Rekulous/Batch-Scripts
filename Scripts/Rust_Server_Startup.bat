@echo off
cls
:start
echo Checking for updates...
g:\steamcmd\steamcmd.exe +login anonymous +force_install_dir g:\rustserver\ +app_update 258550 +quit
echo Starting server...
 
RustDedicated.exe -batchmode -nographics ^
+server.stability true ^
+server.ip 192.168.1.107 ^
+server.port 28015 ^
+server.secure true ^
+server.worldsize 6000 ^
+server.seed fortjp ^
+server.maxplayers 4 ^
+server.hostname "Fort JP Rust Server" ^
+server.identity "Games" ^
+server.level "Procedural Map" ^
+rcon.ip 192.168.1.107 ^
+rcon.port 28016 ^
+server.globalchat true ^
+rcon.password letsplay ^
+server.saveinterval 300 ^
-logfile "output.txt" ^
+server.description "Fort JP" ^
 
echo.
echo Restarting server...
timeout /t 10
echo.
goto start