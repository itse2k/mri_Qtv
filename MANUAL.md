# mri_tv — Manual

Sistema de televisao interativa para FiveM que renderiza video e navegacao web em props de TV/monitor usando DUI como textura 3D.

---

## Sumario

1. [Dependencias](#dependencias)
2. [Instalacao](#instalacao)
3. [Configuracao](#configuracao)
4. [Comandos](#comandos)
5. [Integracoes](#integracoes)
6. [Entrypoints para outros recursos](#entrypoints-para-outros-recursos)
7. [Estrutura de arquivos](#estrutura-de-arquivos)

---

## Dependencias

| Recurso | Obrigatorio | Observacao |
|---|---|---|
| `ox_lib` | Sim | Menus de contexto e input dialogs |
| [Renderer](https://forum.cfx.re/t/release-generic-dui-2d-3d-renderer/131208) | Sim | Renderizacao DUI 2D/3D em props |

---

## Instalacao

1. Copie a pasta `mri_tv` para `resources/`.
2. Adicione ao `server.cfg`:
   ```
   ensure mri_tv
   ```
3. Certifique-se de que `ox_lib` e `Renderer` estao iniciados antes do `mri_tv`.

---

## Configuracao

Documente o arquivo `shared/config.lua`.

| Campo | Tipo | Obrigatorio | Descricao |
|---|---|---|---|
| `Config.Debug` | bool | Nao | Ativa logs de diagnostico no console F8 |
| `Config.Models` | table | Sim | Modelos de props de TV reconhecidos pelo script |
| `Config.Models[model].DefaultVolume` | number | Sim | Volume padrao (0.0 - 1.0) |
| `Config.Models[model].Range` | number | Sim | Distancia maxima de interacao (em unidades de jogo) |
| `Config.Models[model].Target` | string\|nil | Nao | Nome do render target do prop (ex: "tvscreen") |
| `Config.Models[model].Scale` | number | Sim | Escala de renderizacao 3D |
| `Config.Models[model].Offset` | vector3 | Sim | Offset de posicao para renderizacao |
| `Config.Locations` | table | Nao | Locations pré-definidos (requer OneSync) |
| `Config.Locations[].Model` | hash | Sim | Modelo do prop a spawnar |
| `Config.Locations[].Position` | vector4 | Sim | Posicao e heading do prop |
| `Config.Channels` | table | Sim | Canais padrao (nao podem ser sobrescritos por jogadores) |
| `Config.Channels[].name` | string | Sim | Nome do canal |
| `Config.Channels[].url` | string | Sim | URL do conteudo |
| `Config.BannedWords` | table | Sim | Palavras proibidas em URLs (filtra interacoes) |
| `Config.Events.ScreenInteract` | function | Sim | Callback de aprovacao para interacoes com a tela |
| `Config.Events.Broadcast` | function | Sim | Callback de aprovacao para transmissoes |

---

## Comandos

| Comando | Permissao | Descricao |
|---|---|---|
| `/tv` | Todos | Abre o menu de controle da TV mais proxima |
| `/broadcast` | Todos | Inicia ou para uma transmissao ao vivo |

---

## Integracoes

### ox_lib

O recurso utiliza `lib.registerMenu`, `lib.showMenu`, `lib.hideMenu` e `lib.inputDialog` do ox_lib para todos os menus interativos.

### Renderer

A dependencia Renderer fornece a funcionalidade de renderizar o DUI em props 3D via scaleforms. Sem ela, a textura nao sera exibida nos props de TV.

---

## Entrypoints para outros recursos

```lua
-- Eventos de rede (servidor -> cliente)
RegisterNetEvent("ptelevision:event", function(data, index, key, value))
RegisterNetEvent("ptelevision:broadcast", function(data, index))
RegisterNetEvent("ptelevision:requestUpdate", function(data))
RegisterNetEvent("ptelevision:requestSync", function(coords, data))

-- Eventos de rede (cliente -> servidor)
TriggerServerEvent("ptelevision:event", screenData, key, value)
TriggerServerEvent("ptelevision:broadcast", channelData)
TriggerServerEvent("ptelevision:requestUpdate")
TriggerServerEvent("ptelevision:requestSync", coords)
```

---

## Estrutura de arquivos

```
mri_tv/
├── client/
│   ├── cursor.lua       — Cursor interativo para navegacao web
│   ├── dui.lua          — Funcoes auxiliares para render targets
│   ├── main.lua         — Entry point, criacao de DUI/scaleform
│   └── tv.lua           — Menu de controle, reproducao, canais
├── server/
│   └── main.lua         — Logica principal do servidor
├── shared/
│   ├── config.lua       — Configuracao do recurso
│   └── main.lua         — Funcoes compartilhadas e estado global
├── web/
│   ├── blank.html       — UI page transparente (placeholder NUI)
│   ├── index.html       — Pagina principal do display da TV
│   ├── main.js          — Logica JS para YouTube/Twitch/notificacoes
│   ├── style.css        — Estilos do display
│   └── VCR_OSD_MONO_1.001.ttf — Fonte VCR para overlay de canais
└── fxmanifest.lua       — Manifesto do recurso
```
