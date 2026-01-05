@echo off

net session >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo 此檔案必須以系統管理員身分執行。
    echo 請右鍵此檔案，選擇「以系統管理員身分執行」，並按下「是」。
    echo.
    pause
    exit /b
)

setlocal enabledelayedexpansion

set IFACE=Wi-Fi
set DNS1=1.1.1.1
set DNS2=1.0.0.1

echo 偵測目前 DNS 狀態中...
echo.

netsh interface ip show dns name="%IFACE%" | findstr /i "DHCP" >nul

if %errorlevel%==0 (
    echo 目前為【自動 DNS】
    echo 切換為【手動 DNS】

    netsh interface ip set dns name="%IFACE%" static %DNS1%
    netsh interface ip add dns name="%IFACE%" %DNS2% index=2
) else (
    echo 目前為【手動 DNS】
    echo 切換為【自動 DNS】

    echo.
    netsh interface ip set dns name="%IFACE%" dhcp
)

ipconfig /flushdns >nul

echo.
echo DNS 切換完成。
pause
