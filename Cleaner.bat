@echo off
setlocal enabledelayedexpansion

set TotalSize=0

for /r %temp% %%F in (*.*) do (
    set /a FileSize=%%~zF 2>nul
    set /a TotalSize+=FileSize
)
for /r C:\Windows\Temp %%F in (*.*) do (
    set /a FileSize=%%~zF 2>nul
    set /a TotalSize+=FileSize
)
for /r C:\Windows\Prefetch %%F in (*.*) do (
    set /a FileSize=%%~zF 2>nul
    set /a TotalSize+=FileSize
)

set /a SizeInKB=%TotalSize%/1024
set /a SizeInMB=%SizeInKB%/1024
set /a SizeInGB=%SizeInMB%/1024

echo Cleaning temporary files...
rd /s /q %temp% 2>nul
rd /s /q C:\Windows\Temp 2>nul
rd /s /q C:\Windows\Prefetch 2>nul

if not exist %temp% mkdir %temp%
if not exist C:\Windows\Temp mkdir C:\Windows\Temp
if not exist C:\Windows\Prefetch mkdir C:\Windows\Prefetch

if %SizeInGB% geq 1 (
    echo Cleaning completed! [%SizeInGB% GB files removed]
) else if %SizeInMB% geq 1 (
    echo Cleaning completed! [%SizeInMB% MB files removed]
) else (
    echo Cleaning completed! [Less than 1 MB files removed]
)

pause