# mri_tv

Sistema de televisao interativa para FiveM. Renderiza conteudo de video e navegacao web diretamente em props de TV/monitor dentro do jogo, usando DUI (Desktop UI) como textura 3D.

## Principais recursos

- **YouTube** — Reproduz qualquer video do YouTube com sincronizacao de tempo entre jogadores.
- **Twitch** — Reproduz streams ao vivo do Twitch.
- **Broadcast ao vivo** — Jogadores podem registrar canais de transmissao globais.
- **Navegador web** — Navegue pela web diretamente na tela da TV com cursor interativo.
- **Volume por distancia** — O volume diminui conforme o jogador se afasta da TV.
- **Auto-detect** — Detecta automaticamente 18 modelos de props de TV/monitor no mapa.
- **Canais com numeracao** — Estilo VCR (CH 01, CH 12, etc.).

## Instalacao rapida

1. Copie a pasta `mri_tv` para a pasta de resources do servidor.
2. Adicione `ensure mri_tv` no `server.cfg` (apos as dependencias obrigatorias).

## Configuracao

### Dependencias obrigatorias

- `ox_lib` — Menus de contexto e input dialogs.
- [Renderer](https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208) — Renderizacao DUI 2D/3D em props.

### Permissoes

Nenhuma permissao ACE e necessaria. O script utiliza eventos de rede para comunicacao cliente-servidor.

## Comandos

| Comando | Descricao |
|---|---|
| `/tv` | Abre o menu de controle da TV mais proxima. |
| `/broadcast` | Inicia ou para uma transmissao ao vivo. |

## Server Modules

| Modulo | Descricao |
|---|---|
| `main.lua` | Logica principal do servidor (estado das TVs, canais, eventos). |

## Client Modules

| Modulo | Descricao |
|---|---|
| `main.lua` | Entry point do cliente, criacao de DUI/scaleform, deteccao de TVs. |
| `tv.lua` | Menu de controle, reproducao de video/browser, gerenciamento de canais. |
| `dui.lua` | Funcoes auxiliares para render targets e renderizacao de scaleform. |
| `cursor.lua` | Cursor interativo para navegacao web na tela da TV. |

## Estrutura de arquivos

```
mri_tv/
├── client/
│   ├── cursor.lua
│   ├── dui.lua
│   ├── main.lua
│   └── tv.lua
├── server/
│   └── main.lua
├── shared/
│   ├── config.lua
│   └── main.lua
├── web/
│   ├── blank.html
│   ├── index.html
│   ├── main.js
│   ├── style.css
│   └── VCR_OSD_MONO_1.001.ttf
└── fxmanifest.lua
```

## Observacoes importantes

- O recurso utiliza `ui_page` apontando para um HTML transparente (`blank.html`). O conteudo e renderizado exclusivamente via DUI nos props 3D.
- `Config.Locations` requer **OneSync** habilitado no servidor para spawnar props de TV.
- A dependencia `Renderer` deve estar instalada e iniciada antes do `mri_tv`.
- Cada jogador pode definir volume individualmente por TV.
- Canais de broadcast sao automaticamente removidos quando o jogador desconecta.
