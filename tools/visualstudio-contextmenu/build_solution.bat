@echo off

if "%1" == "" goto blank

set SolutionConfig=%2
if "%2" == "" set SolutionConfig=Debug

:build
call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat" amd64
nuget restore %1
devenv /build %SolutionConfig% %1
pause
goto end

:blank
echo Solution file argument missing...

:end
