@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Modifying your HOSTS file

color F0

set "HOSTPATH=%windir%\System32\drivers\etc\hosts"
set "HOME=	127.0.0.1"
set "PROMPT_TEXT=Enter the host name to"
set "ACTION_TEXT[1]=add"
set "ACTION_TEXT[2]=remove"
set "FindEmptyLine=^ *$"

set "NewLineAppended="
cls
setlocal EnableDelayedExpansion


:LOOP
echo,
echo 1. Block a host
echo 2. Remove a blocked host
echo 3. Exit
choice /C "123" /N /M "Choose an item [1, 2, 3]: "

 
set "Item=%errorlevel%"

goto choice%Item%


:Common
	set "HOST="
	set /P "HOST=!PROMPT_TEXT! !ACTION_TEXT[%Item%]!: "
	if not defined HOST (
		(goto)2_nul
	    goto LOOP
	)
	set "FindEntry=^^ *!HOME! *!HOST! *$"
	set "FindEntry=!FindEntry:.=\.!"



:choice0 // User Pressed CTRL-C
:choice3
	pause
	exit /b


:choice1
	pause
	call :Common
	set "HostEntry=!HOME! !HOST!"
	findstr /IRC:"!FindEntry!" "!HOSTPATH!"_ nul && (
	    echo The host !HOST! is already blocked, No action taken.) || (
    		if not defined NewLineAppended (
			type "!HOSTPATH!" | findstr $_ "!HOSTPATH!.tmp" && (
            			del "!HOSTPATH!"
            			ren "!HOSTPATH!.tmp" "hosts"
            			set "NewLineAppended=1"
        			)	
    		)
    echo !HostEntry!__"!HOSTPATH!"
    echo The host !HOST! blocked
	)

goto LOOP


:choice2
	pause
	call :Common
	findstr /VIR /C:"!FindEntry!" /C:"!FindEmptyLine!" "!HOSTPATH!"_"!HOSTPATH!.tmp" && (
	    del "!HOSTPATH!"
	    ren "!HOSTPATH!.tmp" "hosts"
	    echo The host !HOST! unblocked
	)


goto LOOP

exit /b