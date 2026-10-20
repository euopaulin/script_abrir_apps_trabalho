@echo off
setlocal EnableExtensions DisableDelayedExpansion
title Abrir aplicativos de trabalho

rem Opcional: informe o caminho completo do executavel entre o sinal de = e o fim da linha.
rem Exemplo: set "CUSTOM_SLACK=C:\Apps\Slack\slack.exe"
rem Deixe vazio para usar a busca automatica.
set "CUSTOM_SLACK="
set "CUSTOM_CHROME="
set "CUSTOM_CHATGPT="
set "CUSTOM_CLAUDE="
set "CUSTOM_SPOTIFY="
set "CUSTOM_VSCODE="
set "CUSTOM_WHATSAPP="
set "CUSTOM_DISCORD="

echo Abrindo aplicativos de trabalho...
echo.

call :Launch "Slack" "Slack" "%CUSTOM_SLACK%" "%LOCALAPPDATA%\slack\slack.exe" "%LOCALAPPDATA%\Programs\Slack\slack.exe" "%ProgramFiles%\Slack\slack.exe" "%ProgramFiles(x86)%\Slack\slack.exe"
call :Launch "Prompt de Comando" "" "" "%SystemRoot%\System32\cmd.exe"
call :Launch "Google Chrome" "Chrome" "%CUSTOM_CHROME%" "%ProgramFiles%\Google\Chrome\Application\chrome.exe" "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" "%LOCALAPPDATA%\Google\Chrome\Application\chrome.exe"
call :Launch "ChatGPT Desktop" "ChatGPT" "%CUSTOM_CHATGPT%" "%LOCALAPPDATA%\Programs\ChatGPT\ChatGPT.exe" "%LOCALAPPDATA%\ChatGPT\ChatGPT.exe" "%ProgramFiles%\ChatGPT\ChatGPT.exe" "%ProgramFiles(x86)%\ChatGPT\ChatGPT.exe"
call :Launch "Claude Desktop" "Claude" "%CUSTOM_CLAUDE%" "%LOCALAPPDATA%\Programs\Claude\Claude.exe" "%LOCALAPPDATA%\Claude\Claude.exe" "%ProgramFiles%\Claude\Claude.exe" "%ProgramFiles(x86)%\Claude\Claude.exe"
call :Launch "Spotify" "Spotify" "%CUSTOM_SPOTIFY%" "%APPDATA%\Spotify\Spotify.exe" "%LOCALAPPDATA%\Spotify\Spotify.exe" "%ProgramFiles%\Spotify\Spotify.exe" "%ProgramFiles(x86)%\Spotify\Spotify.exe"
call :Launch "Visual Studio Code" "Visual Studio Code" "%CUSTOM_VSCODE%" "%LOCALAPPDATA%\Programs\Microsoft VS Code\Code.exe" "%ProgramFiles%\Microsoft VS Code\Code.exe" "%ProgramFiles(x86)%\Microsoft VS Code\Code.exe"
call :Launch "WhatsApp Desktop" "WhatsApp" "%CUSTOM_WHATSAPP%" "%LOCALAPPDATA%\WhatsApp\WhatsApp.exe" "%LOCALAPPDATA%\Programs\WhatsApp\WhatsApp.exe" "%ProgramFiles%\WhatsApp\WhatsApp.exe" "%ProgramFiles(x86)%\WhatsApp\WhatsApp.exe"
call :LaunchDiscord "%CUSTOM_DISCORD%"

echo.
echo Concluido. Pressione qualquer tecla para fechar esta janela.
pause >nul
exit /b 0

:Launch
set "appName=%~1"
set "shortcutPattern=%~2"
set "customExe=%~3"
shift
shift
shift

if defined customExe if exist "%customExe%" (
    start "" "%customExe%"
    echo [OK] %appName%
    call :Delay
    goto :eof
)
if defined customExe echo [AVISO] Caminho personalizado de %appName% nao encontrado; tentando outros locais.

:TryCandidate
if "%~1"=="" goto :TryShortcut
if exist "%~1" (
    start "" "%~1"
    echo [OK] %appName%
    call :Delay
    goto :eof
)
shift
goto :TryCandidate

:TryShortcut
if not defined shortcutPattern goto :NotFound
set "shortcut="
for /f "delims=" %%S in ('where.exe /r "%APPDATA%\Microsoft\Windows\Start Menu\Programs" "%shortcutPattern%*.lnk" 2^>nul') do if not defined shortcut set "shortcut=%%S"
if not defined shortcut for /f "delims=" %%S in ('where.exe /r "%ProgramData%\Microsoft\Windows\Start Menu\Programs" "%shortcutPattern%*.lnk" 2^>nul') do if not defined shortcut set "shortcut=%%S"
if defined shortcut (
    start "" "%shortcut%"
    echo [OK] %appName% (atalho do Menu Iniciar)
    call :Delay
    goto :eof
)

:NotFound
echo [AVISO] %appName% nao encontrado. Se estiver instalado em outro local, configure o caminho no inicio do arquivo.
goto :eof

:LaunchDiscord
set "customExe=%~1"
if defined customExe if exist "%customExe%" (
    start "" "%customExe%"
    echo [OK] Discord
    call :Delay
    goto :eof
)
if defined customExe echo [AVISO] Caminho personalizado de Discord nao encontrado; tentando outros locais.

rem O instalador desktop do Discord costuma usar Update.exe para iniciar a versao instalada.
if exist "%LOCALAPPDATA%\Discord\Update.exe" (
    start "" "%LOCALAPPDATA%\Discord\Update.exe" --processStart Discord.exe
    echo [OK] Discord
    call :Delay
    goto :eof
)
if exist "%APPDATA%\Discord\Update.exe" (
    start "" "%APPDATA%\Discord\Update.exe" --processStart Discord.exe
    echo [OK] Discord
    call :Delay
    goto :eof
)
call :Launch "Discord" "Discord" "" "%LOCALAPPDATA%\Discord\Discord.exe" "%APPDATA%\Discord\Discord.exe"
goto :eof

:Delay
timeout /t 1 /nobreak >nul
goto :eof
