@echo off
:: Batch file version 
set Version=1.7.2

:: Check if the startup config directory exists if not creat a new directory
if not exist "AdvanceStartup" (
mkdir AdvanceStartup
)

:: Check if the config file exists if not create a new config file
if not exist .\AdvanceStartup\AdvanceStartup.conf (
    goto FIRSTSETUP
) else (
    goto BEGIN
)

:BEGIN

:: Reads the startup config file and fetches the variables from the config file and ignores "#" comments
for /f "delims=" %%i in (.\AdvanceStartup\AdvanceStartup.conf) do (
    if not "%%i" == "#*" (
        for /f "tokens=1,2 delims==" %%a in ("%%i") do (
            set "%%a=%%b"
        )
    )
)

:: Sets the title of the console window
title %Title%
cls

:: Self Advertisement
echo.
echo [40;33m /$$   /$$                                       /$$              /$$$$$$ 
echo [40;33m^| $$  /$$/                                      ^| $$             /$$__  $$
echo [40;33m^| $$ /$$/         /$$$$$$         /$$$$$$       ^| $$   /$$      ^| $$  \ $$
echo [40;33m^| $$$$$/         /$$__  $$       ^|____  $$      ^| $$  /$$/      ^|  $$$$$$/
echo [40;33m^| $$  $$        ^| $$  \__/        /$$$$$$$      ^| $$$$$$/        ^>$$__  $$
echo [40;33m^| $$\  $$       ^| $$             /$$__  $$      ^| $$_  $$       ^| $$  \ $$
echo [40;33m^| $$ \  $$      ^| $$            ^|  $$$$$$$      ^| $$ \  $$      ^|  $$$$$$/
echo [40;33m^|__/  \__/      ^|__/             \_______/      ^|__/  \__/       \______/ 

timeout 2 >nul

cls

:: Prints the current configuration
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
echo Edit AdvanceStartup.conf to make changes to AdvanceStartup
echo Server is starting ...
timeout 6 >nul


set Ram=-Xmx%MaxRam% -Xms%IniRam%

if not exist server.jar (
    if %AutoDownload%==true (
       echo downloading server.jar...
       powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/ServerJars/updater/releases/download/v3.2.2/ServerJars.jar', 'server.jar')"
    )
)

if %Standalone%==true (
    if %AutoRestart%==true (GOTO RESTARTS) ELSE (GOTO STARTS)
)
if %GUI%==true set %GUI%=
if %GUI%==false set GUI=--nogui
if %AutoDownload%==true (
    if %GUI%==--nogui set GUI=--mc.nogui
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
echo [40;37mServer will pause on AdvanceStartup
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
echo [40;37mServer will pause on AdvanceStartup
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

:FIRSTSETUP

doskey y=true
doskey n=false
doskey Y=true
doskey N=false

cls
echo Enter Maximum Ram Allocation for Minecraft Server. ^(Eg:1G,1024M^)
set /p MaxRam=Ram ^(Must have M or G for Megabytes and Gigabytes respectively.^):
if "%MaxRam%" == "" set MaxRam=1G
if defined MaxRam (
    if not "%MaxRam:~-1%"=="M" if not "%MaxRam:~-1%"=="G" (
        echo Invalid input, input should be one or more numbers followed by "M" or "G".
        echo Press any key to start over...
        pause >nul
        goto FIRSTSETUP
    )
)
echo.
echo AutoDownload the server jar file ^(y/n^)
set /p AutoDownload= AutoDownload ^(y/n^):
if "%AutoDownload%" == "" set AutoDownload=true
echo.
echo AutoResrart the Minecraft Server on crash or restart command ^(y/n^)
set /p AutoRestart= AutoResrart ^(y/n^):
if "%AutoRestart%" == "" set AutoRestart=true
echo.
echo Use Aikar flags ^(y/n^)
set /p Flags= Flags ^(y/n^):
if "%Flags%" == "" set Flags=true
echo.
echo Enable server GUI default=n ^(y/n^)
set /p GUI= GUI ^(y/n^):
if "%GUI%" == "" set GUI=false
echo.
echo Do you agree to Minecraft's EULA ^(y/n^)
set /p EULA= EULA ^(y/n^):
if "%EULA%" == "" set EULA=false

echo #  > .\AdvanceStartup\AdvanceStartup.conf
echo #  /$$   /$$                                       /$$              /$$$$$$  >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$  /$$/                                      ^| $$             /$$__  $$ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$ /$$/         /$$$$$$         /$$$$$$       ^| $$   /$$      ^| $$  \ $$ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$$$$/         /$$__  $$       ^|____  $$      ^| $$  /$$/      ^|  $$$$$$/ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$  $$        ^| $$  \__/        /$$$$$$$      ^| $$$$$$/        ^>$$__  $$ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$\  $$       ^| $$             /$$__  $$      ^| $$_  $$       ^| $$  \ $$ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^| $$ \  $$      ^| $$            ^|  $$$$$$$      ^| $$ \  $$      ^|  $$$$$$/ >> .\AdvanceStartup\AdvanceStartup.conf
echo # ^|__/  \__/      ^|__/             \_______/      ^|__/  \__/       \______/  >> .\AdvanceStartup\AdvanceStartup.conf
echo # >> .\AdvanceStartup\AdvanceStartup.conf
echo # Made By Krak8 ^(https^://youtube.com/krak8^) >> .\AdvanceStartup\AdvanceStartup.conf
echo # Git - https^://github.com/Krak8/MC-Startup >> .\AdvanceStartup\AdvanceStartup.conf
echo # >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # AdvanceStartup Version - %Version% ^(Do Not Change^) >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # --------------------------------------------------------------------------------------------------------------------------- >> .\AdvanceStartup\AdvanceStartup.conf
echo #                                         Change the Values in the section below >> .\AdvanceStartup\AdvanceStartup.conf
echo # --------------------------------------------------------------------------------------------------------------------------- >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Change the type of server ^(false = spigot^) ^& ^(true = bungee / waterfall / velocity / standalone^) >> .\AdvanceStartup\AdvanceStartup.conf
echo # if set to true it will run any jar with matching jar name ^(note - it wont use any flags or optimizations^) >> .\AdvanceStartup\AdvanceStartup.conf
echo # set it to true if using older version or vanilla Minecraft jar. >> .\AdvanceStartup\AdvanceStartup.conf
echo Standalone=false >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Define server file name here >> .\AdvanceStartup\AdvanceStartup.conf
echo ServerFileName=server.jar >> .\AdvanceStartup\AdvanceStartup.conf
echo. >> .\AdvanceStartup\AdvanceStartup.conf
echo # Define ram allocation amount here you can use G for Gigabytes or M for Megabytes >> .\AdvanceStartup\AdvanceStartup.conf
echo # Maximum memory allocation pool >> .\AdvanceStartup\AdvanceStartup.conf
echo MaxRam=%MaxRam% >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Restart mode on crash or /restart ^(true/false^) default = true >> .\AdvanceStartup\AdvanceStartup.conf
echo AutoRestart=%AutoRestart% >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Timeout in seconds to restart server if AutoRestart=true . Set it 0 to instantly restart server. default = 10  >> .\AdvanceStartup\AdvanceStartup.conf
echo TimeOut=5 >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Auto Download server jar from https^://serverjars.com/updater ^(auto updater^) >> .\AdvanceStartup\AdvanceStartup.conf
echo # Supports - bukkit, paper, spigot, purpur, tuinity, bungeecord, velocity, waterfall and many more... >> .\AdvanceStartup\AdvanceStartup.conf
echo # Default = false >> .\AdvanceStartup\AdvanceStartup.conf
echo AutoDownload=%AutoDownload% >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Use Aikar flags ^(true/false^) Set it to false if on lower version or server doesnt start with flags. >> .\AdvanceStartup\AdvanceStartup.conf
echo Flags=%Flags% >> .\AdvanceStartup\AdvanceStartup.conf
echo # if MaxRam is 12 G or more then set it to true default = false >> .\AdvanceStartup\AdvanceStartup.conf
echo HFlags=false  >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Vanila server GUI ^(true/false^) >> .\AdvanceStartup\AdvanceStartup.conf
echo GUI=%GUI% >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Define Java Here default = java >> .\AdvanceStartup\AdvanceStartup.conf
echo JAVA=java >> .\AdvanceStartup\AdvanceStartup.conf
echo. >> .\AdvanceStartup\AdvanceStartup.conf
echo # Initial memory allocation pool ^(lower than maxram^) default = 200M >> .\AdvanceStartup\AdvanceStartup.conf
echo IniRam=200M >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # By changing the setting below to TRUE you are indicating your agreement to Mojang EULA ^(https^://account.mojang.com/documents/minecraft_eula^) >> .\AdvanceStartup\AdvanceStartup.conf
echo EULA=%EULA% >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Set console name here >> .\AdvanceStartup\AdvanceStartup.conf
echo Title=Server Console Made By Krak8 ^^(https^^://youtube.com/krak8^^) >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # --------------------------------------------------------------------------------------------------------------------------- >> .\AdvanceStartup\AdvanceStartup.conf
echo #                                                 Advance AdvanceStartup Flags >> .\AdvanceStartup\AdvanceStartup.conf
echo # --------------------------------------------------------------------------------------------------------------------------- >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # ADVANCE FLAGS ONLY IF YOU KNOW HOW TO USE !  >> .\AdvanceStartup\AdvanceStartup.conf
echo # WARNING DO NOT CHANGE THIS UNLESS YOU KNOW WHAT YOU ARE DOING. USE OF WRONG FLAG MIGHT CURRUPT YOUR WORLD. >> .\AdvanceStartup\AdvanceStartup.conf
echo # You can use multiple flags here seperate them with space.  >> .\AdvanceStartup\AdvanceStartup.conf
echo # Available flags - ^( --bonusChest --demo --eraseCache --forceUpgrade --help --initSettings --jfrprofile --port <Integer> --safeMode --serverId <String> echo --singleplayer <String> --universe <String> --world <String> ^) >> .\AdvanceStartup\AdvanceStartup.conf
echo # Check all the Flags from - https^://minecraft.fandom.com/wiki/Tutorials/Setting_up_a_server >> .\AdvanceStartup\AdvanceStartup.conf
echo # if you set Flags=false then u can use custom flags here. just seperate flags using space. >> .\AdvanceStartup\AdvanceStartup.conf
echo.  >> .\AdvanceStartup\AdvanceStartup.conf
echo AdvanceFlags= >> .\AdvanceStartup\AdvanceStartup.conf
goto BEGIN
