@Echo off
@title Space Invaders v 1
@mode con cols=29 lines=25
 
:: Batch Game - Space Invaders v 1
:: Coded by SmartGenius
:: SmartGenius, Corp. 2010
 
Choice /N /T:Y,1 >Nul 2>&1
If "%Errorlevel%"=="9009" (Echo. CHOICE command not found&Pause&Exit)
 
Set "Game=%0"
 
Call :Logo
 
:Menu
Cls
Echo.
Echo.
Echo. Space Invaders v 1
Echo. ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ
Echo. ÚÄÄ¿ ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
Echo. ³1.³ ³Play Game   ³
Echo. ÀÄÄÙ ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
Echo. ÚÄÄ¿ ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
Echo. ³2.³ ³How to Play ³
Echo. ÀÄÄÙ ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
Echo. ÚÄÄ¿ ÚÄÄÄÄÄÄÄÄÄÄÄÄ¿
Echo. ³3.³ ³Exit Game   ³
Echo. ÀÄÄÙ ÀÄÄÄÄÄÄÄÄÄÄÄÄÙ
Echo.
CHOICE /C:123 /N >nul
REM CHOICE /C 123 /N >nul
If "%errorlevel%"=="1" (Goto :Load)
If "%errorlevel%"=="2" (Goto :Help)
If "%errorlevel%"=="3" (Goto :End)
Goto :Menu
 
:Load
Setlocal enabledelayedexpansion
Set /a "LimX=19","LimY=16","TBound=0","LBound=0","Turn=1","Points=0"
Set /a "RBound=%LimX%","BBound=%LimY%"
 
:Init
For /l %%a in (0,1,%LimX%) do (
For /l %%b in (0,1,%LimY%) do (
Set "X%%aY%%b= "))
Set "Bound=Û"
Set "Bound2=²"
Set "Invader="
Set "Shot=o"
 
:Main
Call :Map
Call :Player
Call :Graphic
Goto :Main
 
:Graphic
Call :Clear
Cls
Echo.
Echo.  Space Invaders by Smart
Echo.
Echo.   Points:%Points%
Echo.   ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
For /l %%f in (0,1,%LimY%) do (Echo.   º!Lin_%%f!º)
Echo.   ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
Call :MovFire
If "%N_Invaders%"=="0" Goto :Win
Call :Move
Call :MovPC
Goto :Graphic
 
:Move
:: Normal CHOICE (provided into ZIP package)
REM CHOICE /C WADXC /N >nul
:: Windows 7 or x64 system CHOICE (uncomment)
CHOICE /C:WADXC /N 
If "%errorlevel%"=="1" (Call :Fire)
If "%errorlevel%"=="2" (Call :MovS "Player" "Bound" "-" "L")
If "%errorlevel%"=="3" (Call :MovS "Player" "Bound" "+" "R")
If "%errorlevel%"=="4" (Goto :Menu)
If "%errorlevel%"=="5" (Call :MovCR)
Goto :Eof
 
::::::::::::::::::::::::::::::::::::::::
:Fire
For /f "tokens=4 delims=," %%f in ("%Player%") do (
For /f "tokens=1,2 delims=X,Y" %%g in ("%%f") do (
Set /a "NewF=%%h-1"
Set "X%%gY!NewF!=%Shot%"
Set "Shots=%Shots%,X%%gY!NewF!"
))
Goto :Eof
 
:MovFire
Set "TmpShots="
For %%s in (%Shots%) do (
Call :CkFire "%%s" "TmpCoord" "TmpVal"
If "!TmpVal!"==" " (
Set "%%s= "
Set "!TmpCoord!=%Shot%"
Set "TmpShots=!TmpShots!,!TmpCoord!"
)
If "!TmpVal!"=="" (
Set "%%s= "
)
If "!TmpVal!"=="%Bound2%" (
Set "%%s= "
Set "!TmpCoord!= "
) 
If "!TmpVal!"=="%Invader%" (
Set "%%s= "
Set "!TmpCoord!= "
Set /a "Points+=10"
Set /a "N_Invaders-=1"
Call Set "Invaders=%%Invaders:,!TmpCoord!=%%"
))
Set "Shots=%TmpShots:~1%"
Goto :Eof
 
:CkFire
For /f "tokens=1,2 delims=X,Y" %%g in ("%~1") do (
Set /a "MovY=%%h-1"
Set "%~2=X%%gY!MovY!"
Call Set "%~3=%%X%%gY!MovY!%%"
)
Goto :Eof
 
:MovPC
Set /a "Turn+=1"
Set /a "Dir=(%Turn% %% 6)+1"
If "%Dir%"=="1" Call :MovS "Invaders" "Invader" "-" "L"
If "%Dir%"=="2" Call :MovS "Invaders" "Invader" "-" "L"
If "%Dir%"=="3" Call :MovS "Invaders" "Invader" "-" "L"
If "%Dir%"=="4" Call :MovS "Invaders" "Invader" "+" "R"
If "%Dir%"=="5" Call :MovS "Invaders" "Invader" "+" "R"
If "%Dir%"=="6" Call :MovS "Invaders" "Invader" "+" "R"
Goto :Eof
::::::::::::::::::::::::::
 
:MovCR
Cls
Echo.
Echo.
Call :L2 "Goto :Eof"
Echo.
For /f "tokens=2 skip=3" %%c in ('find "::_0" %Game%') do (
Set "Tmp_Var=%%c"
Call :Key.A Tmp_Var
Echo. !Tmp_Var!
)
Pause >nul
Goto :Eof
 
::::::::::::::::::::::::::::
 
:MovS
Set "TmpTB="
Set "TmpTable=!%~1!"
For %%a in (%TmpTable%) do (
Echo.!TmpTable!|Find "X!%~4Bound!">nul
If !Errorlevel! EQU 0 (Goto :Eof)
Call :MovXR "%~31" "%%a" "Val" 
Call Set "TmpTB=!TmpTB!,!Val!"
)
For %%c in (%TmpTB:~1%) do (
If "!%%c!"=="%Bound2%" (
For %%b in (!%~1!) do (Set "%%b=!%~2!")
Goto :Eof
))
Set "%~1=%TmpTB:~1%"
For %%d in (!%~1!) do (Set "%%d=!%~2!")
Goto :Eof
 
:MovXR
For /f "tokens=1,2 delims=X,Y" %%p in ("%~2") do (
Set /a MovX=%%p%~1
Set "%~3=X!MovX!Y%%q"
Set "%~2= ")
Goto :Eof
 
:::::::::::::::::::::::::
 
:Key.A
If not defined %1 Goto:Eof
Set "c="
Set "d=0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz =/\()[]{}_-.:,;* @#"
:Key.B
Set "chr=!%1:~,1!"
For /l %%l in (0 1 80) do if "!chr!" equ "!d:~%%l,1!" (
  set /a "x=%%l^5"
  call set "c=!c!%%d:~!x!,1%%"
)
Set "%1=!%1:~1!"
If defined %1 goto:Key.B
Set "%1=!c!"
Goto :Eof
 
:::::::::::::::::::::::
 
:Clear
For /l %%m in (0,1,%LimY%) do (Set Lin_%%m=)
For /l %%d in (0,1,%LimY%) do (
For /l %%e in (0,1,%LimX%) do (
Set Lin_%%d=!Lin_%%d!!X%%eY%%d!))
Goto :Eof
 
:Lost
Cls
Echo.
Echo.  Space Invaders by Smart
Echo.
Echo.      Has Perdido !
Echo.
Echo.     Points:%Points%
Echo.
Goto :End
 
:Win
Cls
Echo.
Echo.    Space Invaders v 1 
Echo.   Coded by SmartGenius
Echo.
Echo.    Points:%Points%
Echo.     Has Ganado !
Goto :End
 
:End
Echo.
Echo.     Gracias por Jugar 
Echo.  Space Invaders by Smart
Endlocal
Ping -n 3 localhost >nul
Exit
 
:::::::::::::::::::::::::::::::::
 
:Player
Set Player_Init=X6Y16,X7Y16,X8Y16,X7Y15
Set Player=%Player_Init%
For %%b in (%Player%) do (Set "%%b=%Bound%")
Goto :Eof
 
:Map
For %%a in (
X2Y13,X3Y12,X3Y13,X4Y12,X4Y13,X5Y13,
X8Y13,X9Y12,X9Y13,X10Y12,X10Y13,X11Y13,
X14Y13,X15Y12,X15Y13,X16Y12,X16Y13,X17Y13
) do (Set "%%a=%Bound2%")
For %%b in (
X2Y2,X2Y4,X4Y3,X6Y2,X6Y4,X8Y3,X10Y2,X10Y4,
X12Y3,X14Y2,X14Y4,X16Y3,X18Y2,X18Y4
) do (
Set "Invaders=!Invaders!,%%b"
Set "%%b=%Invader%")
Set "Invaders=%Invaders:~1%"
Set /a "N_Invaders=14"
Goto :Eof
 
::_0 xxxxxxxxxxxxxxxxxxxxxxxxx
::_0 xx9tYjYxWvxPrXmoLjqfzpxxx
::_0 xxxxxXhXxLBINRPFGBaxxxxxx
::_0 xxxxxxxxxxxxxxxxxxxxxxxxx
::_0 xxxxxxxxxxxxxxxxxxxxxxxxx
::_0 xPrXmoLjqfzpx9tms-x7545xx
 
:Help
Cls
Call :L2 "Goto :Eof"
Echo.
Echo.  How to Play Invaders ?
Echo.
Echo.  Use keys A,S,W,X
Echo.
Echo.  A = Move Ship Left
Echo.  S = Move Ship Down
Echo.  W = Throw Fire
Echo.  X = Back to Menu Game
Echo.
Echo. 
Pause >nul
Goto :Menu
 
:Logo
Cls
Color 0a
:L2
Echo.
Echo. °°°°°°°°°°°°°°°°°°°°°°°°°°°
Echo. °°°°°ÛÛ°ÛÛ°°°Û°°°Û°°ÛÛÛ°°°°
Echo. °°°°Û°°°Û°Û°Û°Û°Û°Û°Û°°°°°°
Echo. °°°°°Û°°ÛÛ°°ÛÛÛ°Û°°°ÛÛÛ°°°°
Echo. °°°°°°Û°Û°°°Û°Û°Û°Û°Û°°°°°°
Echo. °°°°ÛÛ°°Û°°°Û°Û°°Û°°ÛÛÛ°°°°
Echo. °°°°°°°°°°°°°°°°°°°°°°°°°°°
Echo. °°±°I°°N°°V°°A°°D°°E°°R°±°°
%~1
Echo. °°±°°°°°°°°°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°°°°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°°o°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°°°°°°°°°°°°°°°°±°°
Echo. °°±°°°²²°°o°²²°°°°²²°°°°±°°
Echo. °°±°°²²²²°°²²²²°°²²²²°°°±°°
Echo. °°±°°°°°°°Û°°°°°°°°°°°°°±°°
Echo. °°±°°°°°°ÛÛÛ°°°°°°°°°°°°±°°
Echo. °°±±±±±±±±±±±±±±±±±±±±±±±°°
Echo. °°°°°°°°°°°°°°°°°°°°°°°°°°°
Echo. °°°°°°: SmartGenius :°°°°°°
Echo. °°°°°°  Corp.  2010  °°°°°°
Echo. °°°°°°°°°°°°°°°°°°°°°°°°°°°
Pause >nul
Goto :Eof