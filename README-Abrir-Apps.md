# Abrir aplicativos de trabalho

## Uso

1. Salve os dois arquivos juntos.
2. Clique duas vezes em `Abrir-Apps-Trabalho.bat`.
3. O script abre os aplicativos encontrados, um por vez, e avisa se algum não estiver instalado.
4. Pressione uma tecla para fechar a janela do script. O Prompt de Comando aberto pelo script continua separado.

## Personalizar caminhos

No início do arquivo `.bat`, cada linha `CUSTOM_*` pode receber o caminho completo do executável. Exemplo:

```bat
set "CUSTOM_SLACK=C:\Apps\Slack\slack.exe"
```

Deixe o valor vazio para a busca automática. Ela verifica locais comuns de instalação e atalhos com o nome do aplicativo no Menu Iniciar. Para instalações personalizadas, use o caminho do arquivo `.exe`. O Discord também pode ser iniciado pelo `Update.exe` do instalador desktop.

O script não abre sites nem instaladores. Slack, Chrome, ChatGPT Desktop, Claude Desktop, Spotify, Visual Studio Code, WhatsApp Desktop e Discord precisam estar instalados no computador.
