@echo off

:javaInstall

echo Choose the java version to install (1-5):
echo 1. Java 8  ^(1.8 to 1.11^)
echo 2. Java 11 ^(1.12 to 1.16.4^)
echo 3. Java 16 ^(1.16.5^)
echo 4. Java 17 ^(1.17.1 to 1.19.2^)
echo 5. Java 21 ^(1.20^+^)
CHOICE /N /C:12345

if %errorlevel%==1 (
    cls
    echo Installing Java 8
    winget install --id "EclipseAdoptium.Temurin.8.JDK" -i
)

if %errorlevel%==2 (
    cls
    echo Installing Java 11
    winget install --id "EclipseAdoptium.Temurin.11.JDK" -i
)

if %errorlevel%==3 (
    cls
    echo Installing Java 16
    winget install --id "EclipseAdoptium.Temurin.16.JDK" -i
)

if %errorlevel%==4 (
    cls
    echo Installing Java 17
    winget install --id "EclipseAdoptium.Temurin.17.JDK" -i
)

if %errorlevel%==5 (
    cls
    echo Installing Java 21
    winget install --id "EclipseAdoptium.Temurin.21.JDK" -i
)

pause