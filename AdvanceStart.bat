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
::

@echo off
:: credits of author
set Credits=Made By Krak8 ^(https^://youtube.com/krak8^)

:: Define server file name here
set ServerFileName=server.jar

:: Define Java Here
set JAVA=java

:: By changing the setting below to TRUE you are indicating your agreement to Mojang EULA (https://account.mojang.com/documents/minecraft_eula)
set EULA=true

:: Set console name here
set Title=Server Console %Credits%
title %Title%

:: Define ram allocation amount here you can use G for Gigabytes or M for Megabytes
:: Maximum memory allocation pool
set MaxRam=4G
:: if MaxRam is 12 G or more then set it to true default = false
set HFlags=false 
:: Initial memory allocation pool
set IniRam=200M

:: Vanila server GUI (true/false)
set GUI=false


:: -----------------------------------------------
:: WARNING DO NOT CHANGE ANYTHING BELOW THIS LINE
:: Note: if something breaks contact Krak8 : https://youtube.com/krak8
:: -----------------------------------------------


echo.
echo %Credits%
echo ....................................
echo Starting %ServerFileName%
echo Maximum memory: %MaxRam%
echo Initial memory: %IniRam%
echo Advance Flags(12gb+ server only): %HFlags%
echo Vaanila GUI: %GUI%
echo ....................................
timeout 20

set Ram=-Xmx%MaxRam% -Xms%IniRam%

if %GUI%==true set %GUI%=
if %GUI%==false set GUI=--nogui
if %HFlags%==true set FLAGS=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
if %HFlags%==false set FLAGS=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
if %EULA%==true (
    @echo off
    cd %localhost%
    echo #By changing the setting below to TRUE you are indicating your agreement to our EULA ^(https://account.mojang.com/documents/minecraft_eula^)^.> eula.txt
    echo #You also agree that tacos are tasty, and the best food in the world^.>> eula.txt
    echo #Auto generated EULA from script Made By Krak8 ^(https^://youtube.com/krak8^)^. >> eula.txt
    echo eula=true>> eula.txt
    )

:Start
cls

echo %Credits%
%JAVA% %Ram% %FLAGS% -jar %ServerFileName% %GUI%
echo %Credits%

timeout 20
cls
echo %Credits%
echo.
echo Server has closed or crashed...
echo.
echo The Server will restart after the timeout close console window to stop server now!
timeout 20
goto Start
