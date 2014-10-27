@echo off

if "%1" == "" goto blank

set SolutionConfig=%2
if "%2" == "" set SolutionConfig=Debug

:build
call "%VS100COMNTOOLS%\..\..\VC\vcvarsall.bat" amd64
FOR /R %1 %%F IN (*.sln) DO (
  echo.
  echo.
  echo ### Building %%F
  echo.
  echo.
  nuget restore %%F
  devenv /build %SolutionConfig% %%F
)

pause
goto end

:blank
echo Directory argument missing...

:end
