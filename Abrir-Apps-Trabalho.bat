
@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Inicializador de Aplicativos

:: =====================================================
:: SOLICITAR ADMINISTRADOR
:: =====================================================

net session >nul 2>&1

if %errorlevel% neq 0 (
    powershell -NoProfile -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: =====================================================
:: CAMINHOS DOS EXECUTAVEIS
:: =====================================================

set "CMD=%SystemRoot%\System32\cmd.exe"
set "CHROME=%ProgramFiles%\Google\Chrome\Application\chrome.exe"
set "CHATGPT=%LOCALAPPDATA%\Programs\ChatGPT\ChatGPT.exe"
set "SPOTIFY=%APPDATA%\Spotify\Spotify.exe"
set "VSCODE=%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe"
set "DISCORD=%LOCALAPPDATA%\Discord\Update.exe"

:: =====================================================
:: INICIALIZAR APLICATIVOS MSIX
:: =====================================================

:: Slack
call :LaunchApp "Slack" "com.tinyspeck.slackdesktop_8yrtsj140pw4g!Slack"

:: WhatsApp
call :LaunchApp "WhatsApp" "5319275A.WhatsAppDesktop_cv1g1gvanyjgm!App"

:: =====================================================
:: INICIALIZAR APLICATIVOS EXE
:: =====================================================

call :LaunchExe "Prompt de Comando" "%CMD%"
call :LaunchExe "Google Chrome" "%CHROME%"
call :LaunchExe "ChatGPT" "%CHATGPT%"
call :LaunchExe "Spotify" "%SPOTIFY%"
call :LaunchExe "Visual Studio Code" "%VSCODE%"

:: Discord
if exist "%DISCORD%" (
    start "" "%DISCORD%" --processStart Discord.exe
)

endlocal
exit /b 0

:: =====================================================
:: FUNCAO: ABRIR APLICATIVOS MSIX
:: =====================================================

:LaunchApp
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
"try { Start-Process ('shell:AppsFolder\' + '%~2') -ErrorAction Stop; exit 0 } catch { exit 1 }"

if errorlevel 1 (
    echo [ERRO] %~1
) else (
    echo [OK] %~1
)

goto :eof

:: =====================================================
:: FUNCAO: ABRIR EXECUTAVEIS
:: =====================================================

:LaunchExe
if exist "%~2" (
    start "" "%~2"
    echo [OK] %~1
) else (
    echo [ERRO] %~1 - Executavel nao encontrado
)
goto :eof
