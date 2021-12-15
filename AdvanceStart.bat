@echo off
::
::  /$$   /$$                                       /$$              /$$$$$$ 
:: | $$  /$$/                                      | $$             /$$__  $$
:: | $$ /$$/         /$$$$$$         /$$$$$$       | $$   /$$      | $$  \ $$
:: | $$$$$/         /$$__  $$       |____  $$      | $$  /$$/      |  $$$$$$/
:: | $$  $$        | $$  \__/        /$$$$$$$      | $$$$$$/        >$$__  $$
:: | $$\  $$       | $$             /$$__  $$      | $$_  $$       | $$  \ $$
:: | $$ \  $$      | $$            |  $$$$$$$      | $$ \  $$      |  $$$$$$/
:: |__/  \__/      |__/             \_______/      |__/  \__/       \______/ 
::
:: Made By Krak8 (https://youtube.com/krak8)
:: https://github.com/Krak8/MC-Startup
::

:: Startup Version - v1.0.1 (Do Not Change)

:: ---------------------------------------------------------------------------------------------------------------------------
::                                 Change the Values in the sction below
:: ---------------------------------------------------------------------------------------------------------------------------

:: Define server file name here
set ServerFileName=server.jar

:: Define ram allocation amount here you can use G for Gigabytes or M for Megabytes
:: Maximum memory allocation pool
set MaxRam=4G
:: if MaxRam is 12 G or more then set it to true default = false
set HFlags=false 
:: Initial memory allocation pool (lower than maxram) default = 200M
set IniRam=200M

:: Restart mode on crash or /restart (true or false) default = true
set AutoRestart=true

:: Timeout in seconds to restart server if AutoRestart=true default = 10
set TimeOut=10

:: Vanila server GUI (true/false)
set GUI=false

:: Define Java Here
set JAVA=java

:: By changing the setting below to TRUE you are indicating your agreement to Mojang EULA (https://account.mojang.com/documents/minecraft_eula)
set EULA=true

:: Set console name here
set Title=Server Console Made By Krak8 ^(https^://youtube.com/krak8^)

:: ---------------------------------------------------------------------------------------------------------------------------
:: ---------------------------------------------------------------------------------------------------------------------------

:: -----------------------------------------------
:: WARNING DO NOT CHANGE ANYTHING BELOW THIS LINE
:: Note: if something breaks contact Krak8 : https://youtube.com/krak8
:: -----------------------------------------------




















title %Title%
cls
echo.
echo [40;33m /$$   /$$                                       /$$              /$$$$$$ 
echo [40;33m^| $$  /$$/                                      ^| $$             /$$__  $$
echo [40;33m^| $$ /$$/         /$$$$$$         /$$$$$$       ^| $$   /$$      ^| $$  \ $$
echo [40;33m^| $$$$$/         /$$__  $$       ^|____  $$      ^| $$  /$$/      ^|  $$$$$$/
echo [40;33m^| $$  $$        ^| $$  \__/        /$$$$$$$      ^| $$$$$$/        ^>$$__  $$
echo [40;33m^| $$\  $$       ^| $$             /$$__  $$      ^| $$_  $$       ^| $$  \ $$
echo [40;33m^| $$ \  $$      ^| $$            ^|  $$$$$$$      ^| $$ \  $$      ^|  $$$$$$/
echo [40;33m^|__/  \__/      ^|__/             \_______/      ^|__/  \__/       \______/ 

timeout 3 >nul

cls
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;36m.......................................................
echo [40;32mStarting %ServerFileName%
echo Maximum memory: %MaxRam% Initial memory: %IniRam%
echo AutoRestart: %AutoRestart%
echo EULA: %EULA%
echo Advance Flags(12gb+ server only): %HFlags%
echo Vanila GUI: %GUI%
echo [40;36m.......................................................[0m
echo Server is starting ...
timeout 10 >nul


set Ram=-Xmx%MaxRam% -Xms%IniRam%

if %GUI%==true set %GUI%=
if %GUI%==false set GUI=--nogui
if %HFlags%==true set FLAGS=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
if %HFlags%==false set FLAGS=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
if %EULA%==true (
    cd %localhost%
    echo #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^)^.> eula.txt
    echo #You also agree that tacos are tasty, and the best food in the world^.>> eula.txt
    echo #Auto generated EULA from script Made By Krak8 ^(https^://youtube.com/krak8^)^. >> eula.txt
    echo eula=true>> eula.txt
    )
if %EULA%==false (
    cd %localhost%
    echo #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^)^.> eula.txt
    echo #You also agree that tacos are tasty, and the best food in the world^.>> eula.txt
    echo #Auto generated EULA from script Made By Krak8 ^(https^://youtube.com/krak8^)^. >> eula.txt
    echo eula=false>> eula.txt
    )
if %AutoRestart%==true (GOTO RESTART) ELSE (GOTO START)

:START
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %FLAGS% -jar %ServerFileName% %GUI%
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo.
echo.
echo [40;31mServer has closed or crashed...
echo The Server will not AutoRestart
echo [40;37mServer will pause on Startup
echo.
timeout 20 >nul
goto Main

:RESTART
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %FLAGS% -jar %ServerFileName% %GUI%
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
timeout %TimeOut%
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo.
echo [40;31mServer has closed or crashed...
echo.
echo [40;32mThe Server will restart after the timeout close console window to stop server now![0m
timeout %TimeOut%
goto RESTART

:Main
cls
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;36m.......................................................
echo [40;32mServerJarName: %ServerFileName%
echo Maximum memory: %MaxRam% Initial memory: %IniRam%
echo AutoRestart: %AutoRestart%
echo EULA: %EULA%
echo Advance Flags(12gb+ server only): %HFlags%
echo Vanila GUI: %GUI%
echo [40;36m.......................................................[0m
echo.
echo [40;32mPress any Key to start ...[0m
echo Press [40;36mctr ^+ c[0m to stop the process
Pause >nul
goto START
