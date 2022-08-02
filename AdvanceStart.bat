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
:: Git - https://github.com/Krak8/MC-Startup
::

:: Startup Version - v1.1.0 (Do Not Change)

:: ---------------------------------------------------------------------------------------------------------------------------
::                                         Change the Values in the section below
:: ---------------------------------------------------------------------------------------------------------------------------

:: Change the type of server (false = spigot) & (true = bungee / waterfall / velocity / standalone)
:: if set to true it will run any jar with matching jar name (note - it wont use any flags or optimizations)
:: set it to true if using older version or vanilla Minecraft jar.
set Standalone=false

:: Define server file name here
set ServerFileName=server.jar

:: Define ram allocation amount here you can use G for Gigabytes or M for Megabytes
:: Maximum memory allocation pool
set MaxRam=1G

:: Restart mode on crash or /restart (true/false) default = true
set AutoRestart=true

:: Timeout in seconds to restart server if AutoRestart=true . Set it 0 to instantly restart server. default = 10 
set TimeOut=10

:: Auto Download server jar from https://serverjars.com/updater (auto updater)
:: Supports - bukkit, paper, spigot, purpur, tuinity, bungeecord, velocity, waterfall and many more...
:: Default = false
set AutoDownload=false

:: Use Aikar flags (true/false) Set it to false if on lower version or server doesnt start with flags.
set Flags=true
:: if MaxRam is 12 G or more then set it to true default = false
set HFlags=false 

:: Vanila server GUI (true/false)
set GUI=false

:: Define Java Here default = java
set JAVA=java

:: Initial memory allocation pool (lower than maxram) default = 200M
set IniRam=200M

:: By changing the setting below to TRUE you are indicating your agreement to Mojang EULA (https://account.mojang.com/documents/minecraft_eula)
set EULA=true

:: Set console name here
set Title=Server Console Made By Krak8 ^(https^://youtube.com/krak8^)

:: ---------------------------------------------------------------------------------------------------------------------------
::                                                 Advance Startup Flags
:: ---------------------------------------------------------------------------------------------------------------------------

:: ADVANCE FLAGS ONLY IF YOU KNOW HOW TO USE ! 
:: WARNING DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING. USE OF WRONG FLAG MIGHT CURRUPT YOUR WORLD.
:: You can use multiple flags here seperate them with space. 
:: Available flags - ( --bonusChest --demo --eraseCache --forceUpgrade --help --initSettings --jfrprofile --port <Integer> --safeMode --serverId <String> --singleplayer <String> --universe <String> --world <String> )
:: Check all the Flags from - https://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server
:: if you set Flags=false then u can use custom flags here. just seperate flags using space.

set AdvanceFlags=

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
echo [40;32mStandalone/Proxy: %Standalone%
echo Starting %ServerFileName%
echo Maximum memory: %MaxRam% Initial memory: %IniRam%
echo Flags: %Flags% 12Gb^+: %HFlags%
echo AutoRestart: %AutoRestart%
echo EULA: %EULA%
echo Vanila GUI: %GUI%
echo [40;36m.......................................................[0m
echo Server is starting ...
timeout 3 >nul


set Ram=-Xmx%MaxRam% -Xms%IniRam%

if not exist server.jar (
    if %AutoDownload%==true (
       echo downloading server.jar...
       powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/ServerJars/updater/releases/download/v3.2.0/ServerJars.jar', 'server.jar')"
    )
)

if %Standalone%==true (
    if %AutoRestart%==true (GOTO RESTARTS) ELSE (GOTO STARTS)
)
if %GUI%==true set %GUI%=
if %GUI%==false (
    if %AutoDownload%==true set GUI=--mc.nogui
    else set GUI=--nogui
)
if %Flags%==true (
    if %HFlags%==true set FlagsT=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=40 -XX:G1MaxNewSizePercent=50 -XX:G1HeapRegionSize=16M -XX:G1ReservePercent=15 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=20 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
    if %HFlags%==false set FlagsT=-XX:+UseG1GC -XX:+ParallelRefProcEnabled -XX:MaxGCPauseMillis=200 -XX:+UnlockExperimentalVMOptions -XX:+DisableExplicitGC -XX:+AlwaysPreTouch -XX:G1NewSizePercent=30 -XX:G1MaxNewSizePercent=40 -XX:G1HeapRegionSize=8M -XX:G1ReservePercent=20 -XX:G1HeapWastePercent=5 -XX:G1MixedGCCountTarget=4 -XX:InitiatingHeapOccupancyPercent=15 -XX:G1MixedGCLiveThresholdPercent=90 -XX:G1RSetUpdatingPauseTimePercent=5 -XX:SurvivorRatio=32 -XX:+PerfDisableSharedMem -XX:MaxTenuringThreshold=1 -Daikars.new.flags=true -Dusing.aikars.flags=https://mcflags.emc.gs
)
if %Flags%==flags set FlagsT=
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
if %AutoRestart%==true (GOTO RESTARTM) ELSE (GOTO STARTM)

:STARTM
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %FlagsT% %AdvanceFlags% -jar %ServerFileName% %GUI%
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo.
echo.
echo [40;31mServer has closed or crashed...
echo The Server will not AutoRestart
echo [40;37mServer will pause on Startup
echo.
timeout 20 >nul
goto MainM

:RESTARTM
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %FlagsT% %AdvanceFlags% -jar %ServerFileName% %GUI%
echo.
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;31mServer has closed or crashed...
echo.
echo [40;32mThe Server will restart after %TimeOut%s timeout close console window to stop server now![0m
timeout %TimeOut%
goto RESTARTM

:MainM
cls
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;36m.......................................................
echo [40;32mServerJarName: %ServerFileName%
echo Maximum memory: %MaxRam% Initial memory: %IniRam%
echo Flags: %Flags% 12Gb^+: %HFlags%
echo AutoRestart: %AutoRestart%
echo EULA: %EULA%
echo Vanila GUI: %GUI%
echo [40;36m.......................................................[0m
echo.
echo [40;32mPress any Key to start ...[0m
echo Press [40;36mctr ^+ c[0m to stop the process
Pause >nul
goto STARTM

:STARTS
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %AdvanceFlags% -jar %ServerFileName%
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo.
echo.
echo [40;31mServer has closed or crashed...
echo The Server will not AutoRestart
echo [40;37mServer will pause on Startup
echo.
timeout 20 >nul
goto MainS

:RESTARTS
cls
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)[0m
%JAVA% %Ram% %AdvanceFlags% -jar %ServerFileName%
echo.
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;31mServer has closed or crashed...
echo.
echo [40;32mThe Server will restart after %TimeOut%s timeout close console window to stop server now![0m
timeout %TimeOut%
goto RESTARTS

:MainS
cls
echo.
echo [40;33mServer Console Made By Krak8 ^(https^://youtube.com/krak8^)
echo [40;36m.......................................................
echo [40;32mServerJarName: %ServerFileName%
echo Maximum memory: %MaxRam% Initial memory: %IniRam%
echo AutoRestart: %AutoRestart%
echo [40;36m.......................................................[0m
echo.
echo [40;32mPress any Key to start ...[0m
echo Press [40;36mctr ^+ c[0m to stop the process
Pause >nul
goto STARTS
