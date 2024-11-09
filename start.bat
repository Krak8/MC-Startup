@echo off
setlocal enabledelayedexpansion
set Version=1.7.5
set configDir=.\.AdvanceStartup
:: change the line below to use different java (point to java.exe)
set java=java

:firstbootcheck
 :: Check if the startup config directory exists if not creat a new directory & configfile
 if not exist "%configDir%" (
    call :firstboot
)

:: Reads the startup config file and fetches the variables from the config file and ignores "#" comments
for /f "delims=" %%i in (%configDir%\settings.yml) do (
    if not "%%i" == "#*" (
        for /f "tokens=1,2 delims=: " %%a in ("%%i") do (
            set "%%a=%%b"
        )
    )
)

:: Sets the title of the console window
title %Title%
cls
call :k8
timeout 2 >nul
cls
:: Prints the current configuration
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://krak8.xyz^)
echo [40;36m.......................................................
echo [40;32mStandalone/Proxy: [40;33m%proxy%
echo [40;32mStarting [40;33m%serverjar%
echo [40;32mMaximum memory: [40;33m%maxram% [40;32mInitial memory: [40;33m%iniRam%
echo [40;32mUse Aikar Flags: [40;33m%aikarflags%
echo [40;32mAutoRestart: [40;33m%autorestart%
echo [40;32mEULA: [40;33m%EULA%
echo [40;32mVanila GUI: [40;33m%GUI%
echo [40;36m.......................................................[0m
echo To make changes to current configuration press 0
echo Server is starting ...
CHOICE /N /T 6 /D 9 /C:09 
cls
if %errorlevel%==1 ( call  :configedit )

:autorestart
if %autorestart%==true (
    call :startserver
    echo [40;31mServer has closed or crashed...
    echo.
    echo [40;32mThe Server will restart after %TimeOut%s timeout close console window to stop server or press ctrl^+c ![0m
    timeout %TimeOut% >nul
    goto :autorestart
)

:startserver
call :ram
call :flags
call :gui
call :pre_autodownload
call :eula 

:: Running the forge server
if %aServerJarType%==forge ( %java% %ram% @libraries/net/minecraftforge/forge/%afilename%/win_args.txt %gui% %* )
:: Running the proxy/normal server
if %proxy%==true ( %java% %ram% -jar %serverjar% ) else (
    %java% %ram% %flags% -jar %serverjar% %gui%
)
goto :eof
exit

:ram
:: Set the ram var 
set ram=-Xmx%maxram% -Xms%iniRam%
cls
goto :eof

:eula
if %EULA%==true ( 
    (
        echo #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^).
        echo #You also agree that tacos are tasty, and the best food in the world.
        echo #Auto generated EULA from script Made By Krak8 ^(https^://youtube.com/krak8^).
        echo eula=true
    ) > eula.txt
)
if %EULA%==false ( 
    (
        echo #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^).
        echo #You also agree that tacos are tasty, and the best food in the world.
        echo #Auto generated EULA from script Made By Krak8 ^(https^://youtube.com/krak8^).
        echo eula=false
    ) > eula.txt
)

:flags
(
    :: basic aikar flags
    set bflag=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcutils.com
    :: advance aikar flags for 12Gb +
    set aflag=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcutils.com

    :: Extract the numeric part and the unit
    set "ramValue=%maxram:~0,-1%"
    set "ramUnit=%maxram:~-1%"
)
:: Convert to megabytes
if /i "%ramUnit%"=="G" (
    set /a ramM= %ramValue% * 1024
)

if %aikarflags%==true (
    :: Compare the value
    if %ramM% lss 12288 (
        set "flags=%bflag% %AdvanceFlags%"
    ) else (
        set "flags=%aflag% %AdvanceFlags%"
    )
)
cls
goto :eof

:gui
if %GUI%==true set %gui%=
if %GUI%==false set gui=--nogui
cls
goto :eof

:pre_autodownload
:: Reads the server auto download log and fetches the variables from the file if exists and ignores "#" comments
for /f "delims=" %%i in (%configDir%\autodownload.log) do (
    if not "%%i" == "#*" (
        for /f "tokens=1,2 delims=: " %%a in ("%%i") do (
            set "%%a=%%b"
        )
    )
)
if %autodownload%==true (
    if not exist "%configDir%\autodownload.log" ( call :autodownload ) else (
        echo You are currently using %aServerJarType%^-%aServerVersion% 
        echo if you want to change or update the curent server jar press 0 else ignore.
        CHOICE /N /T 6 /D 9 /C:09
        if %errorlevel%==1 ( call  :autodownload )
    )
)
cls
goto :eof

:firstboot
cls
set configUrl=https://raw.githubusercontent.com/Krak8/MC-Startup/refs/heads/main/assets/settings.yml
mkdir %configDir%

cls
echo.
echo This is the first time you are using this Minecraft Server Starter.
echo Please wait for few moments while we create a config file.
echo You will be prompted to edit a settings.yml file using your default editor.
powershell -Command "(New-Object Net.WebClient).DownloadFile('%configUrl%', '%configDir%\settings.yml')"
timeout 10 >nul
cls

:configedit
echo.
echo Press any key once you are done editing the settings.
echo Remember to save the file before pressing key
start "" "%configDir%\settings.yml"
pause >nul
cls
goto :eof

:autodownload
del %serverjar%
set autoUrl=https://mcutils.com/api/server-jars
:: Fetch the JSON data using PowerShell and save it to a temporary file
powershell -Command "Invoke-WebRequest -Uri '%autoUrl%' -UseBasicParsing | Select-Object -ExpandProperty Content | Out-File -FilePath server.json"

:: Parse the JSON and extract the keys using PowerShell
for /f "tokens=*" %%i in ('powershell -Command "Get-Content server.json | ConvertFrom-Json | ForEach-Object { $_.key }"') do (
    set /a count+=1
    set "key!count!=%%i"
)

:: Display the options to the user
echo Please choose the server jar:
for /l %%i in (1,1,%count%) do (
    echo %%i. !key%%i!
)

:: Get user input
set /p choice=Enter the number of your choice: 

:: Validate the input and save the selected key in a variable
if %choice% gtr 0 if %choice% leq %count% (
    set "autoServerJar=!key%choice%!"
    echo You selected: !autoServerJar!
    :: Clean up the temporary file
    del server.json
) else (
    echo Invalid choice.
    pause
    exit
)
echo.
echo.

set choice=0
set count=0


:: Fetch available minecraft versions
powershell -Command "Invoke-WebRequest -Uri '%autoUrl%/!autoServerJar!' -UseBasicParsing | Select-Object -ExpandProperty Content | Out-File -FilePath version.json"

:: Parse the JSON and extract the version using PowerShell
for /f "tokens=*" %%i in ('powershell -Command "Get-Content version.json | ConvertFrom-Json | ForEach-Object { $_.version }"') do (
    set /a count+=1
    set "version!count!=%%i"
)
:: Display the options to the user
echo Please choose the version:
for /l %%i in (1,1,%count%) do (
    echo %%i. !version%%i!
)
:: Get user input
set /p choice=Enter the number of your choice: 
:: Validate the input and save the selected key in a variable
if %choice% gtr 0 if %choice% leq %count% (
    set "autoVersion=!version%choice%!"
    echo You selected: !autoVersion!
    :: Clean up the temporary file
    del version.json
) else (
    echo Invalid choice.
    pause
    exit
)
(
echo aServerJarType: !autoServerJar!
echo aServerVersion: !autoVersion!
echo aDate: %date%
echo aURL: %autoUrl%/!autoServerJar!/!autoVersion!/download
) > %configDir%\autodownload.log
cls

echo Downloading the server jar ^(!autoServerJar!^-!autoVersion!^) please wait...
powershell -Command "(New-Object Net.WebClient).DownloadFile('%autoUrl%/!autoServerJar!/!autoVersion!/download', '%serverjar%')"
echo The server jar (!autoServerJar!^-!autoVersion!^) has been downloaded and saved as %serverjar%

:: handler for forge
if !autoServerJar!==forge (
    :: Download the file and save the response headers
    curl -IL "%autoUrl%/!autoServerJar!/!autoVersion!/download" > headers.txt
    :: Read the line from headers.txt
    for /f "tokens=2 delims=;" %%a in ('findstr /i "content-disposition" headers.txt') do (
        set rawname=%%a
    )
    rem Remove "forge-" and "-installer.jar" 
    set "temp=!rawname:"forge-=!" 
    set "rawfilename=!temp:-installer.jar"=!"
    rem Extract the filename
    for /f "tokens=2 delims== " %%a in ("!rawfilename!") do (
        set filename=%%a
    )
    echo afilename: !filename! >> %configDir%\autodownload.log
    %java% -jar %serverjar% --installServer
    del headers.txt
    del user_jvm_args.txt
    del server.jar.log
    del run.bat
    del run.sh
)
timeout 2 >nul
cls
goto :startserver

:k8
echo.
echo [40;33m /$$   /$$                                       /$$              /$$$$$$ 
echo [40;33m^| $$  /$$/                                      ^| $$             /$$__  $$
echo [40;33m^| $$ /$$/         /$$$$$$         /$$$$$$       ^| $$   /$$      ^| $$  \ $$
echo [40;33m^| $$$$$/         /$$__  $$       ^|____  $$      ^| $$  /$$/      ^|  $$$$$$/
echo [40;33m^| $$  $$        ^| $$  \__/        /$$$$$$$      ^| $$$$$$/        ^>$$__  $$
echo [40;33m^| $$\  $$       ^| $$             /$$__  $$      ^| $$_  $$       ^| $$  \ $$
echo [40;33m^| $$ \  $$      ^| $$            ^|  $$$$$$$      ^| $$ \  $$      ^|  $$$$$$/
echo [40;33m^|__/  \__/      ^|__/             \_______/      ^|__/  \__/       \______/ 
goto :eof
