# Plano de Porting: ptelevision v1.2.5 → mri_tv

## Objetivo

Mover toda a funcionalidade do `ptelevision v1.2.5` (Pickle Mods) para a estrutura do template `mri_Qtv` (MRI Qbox Team), mantendo as CI/CD workflows, convencoes de nomenclatura e limpando todas as referencias ao autor original.

---

## Origem

- **Script original:** `ptelevision v1.2.5` por Pickle Mods
- **Template destino:** `mri_Qtv` (MRI Qbox Team / mri-Qbox-Brasil)

---

## Decisoes de porting

| Decisao | Escolha | Motivo |
|---|---|---|
| Nome do recurso | `mri_tv` | Padrao MRI, curto e direto |
| Dependencia Renderer | Mantida como externa | Recurso separado no fórum CFX |
| Referencias a Pickle Mods | Removidas | Limpeza total de branding anterior |
| Diretorio NUI | `web/` (era `html/`) | Convenco do template MRI |
| OneSync Locations | Mantido | Funcionalidade util, documentada como opcional |
| Nomes dos eventos | Mantidos (`ptelevision:*`) | Evitar quebras internas, sao internos ao recurso |
| Menu ID ox_lib | Renomeado para `mri_tv-menu` | Identificacao clara do recurso |

---

## Arquivos modificados

### Novos (copiados do ptelevision e adaptados)

| Arquivo | Origem | Alteracoes |
|---|---|---|
| `shared/config.lua` | `config.lua` (raiz) + template | Fusao: Config.Debug do template + toda config do ptelevision |
| `shared/main.lua` | `shared/main.lua` | Copia direta |
| `client/main.lua` | `client/main.lua` | URL dinamica via GetCurrentResourceName(), log com Config.Debug |
| `client/cursor.lua` | `client/cursor.lua` | Limpeza de comentarios |
| `client/dui.lua` | `client/dui.lua` | Copia direta |
| `client/tv.lua` | `client/tv.lua` | Menu ID renomeado para mri_tv-menu |
| `server/main.lua` | `server/main.lua` | Adicionado onResourceStart com Config.Debug |

### Web (renomeados de html/ para web/)

| Arquivo | Alteracao |
|---|---|
| `web/blank.html` | Copia direta |
| `web/index.html` | Copia direta |
| `web/style.css` | Copia direta |
| `web/main.js` | NUI callback URL atualizado de `ptelevision` para `mri_tv` |
| `web/VCR_OSD_MONO_1.001.ttf` | Copia direta |

### Atualizados

| Arquivo | Alteracoes |
|---|---|
| `fxmanifest.lua` | Author, description, version placeholder, ui_page, files para web/, shared_scripts com ox_lib |
| `.templatesyncignore` | Adicionado `shared/config.lua` e `web/*` |
| `README.md` | Reescrito do zero seguindo template MRI |
| `MANUAL.md` | Reescrito do zero seguindo template MRI |

### Mantidos intactos

| Arquivo | Motivo |
|---|---|
| `.github/workflows/*.yml` | CI/CD do template |
| `.github/templates/*.template.md` | Templates de doc |
| `.github/SETUP.md` | Guia de setup |
| `.gitignore` | Configuracao do template |
| `.release/package.json` | Tooling de release |
| `CHANGELOG.md` | Historico do template |

---

## Estrutura final

```
mri_tv/
├── .github/
│   ├── SETUP.md
│   ├── templates/
│   │   ├── MANUAL.template.md
│   │   └── README.template.md
│   └── workflows/
│       ├── lint.yml
│       ├── port-pr.yml
│       ├── release.yml
│       ├── repo-dispatch.yml
│       ├── template-sync.yml
│       └── update-actions.yml
├── .gitignore
├── .release/
│   └── package.json
├── .templatesyncignore
├── CHANGELOG.md
├── MANUAL.md
├── README.md
├── PORTING_PLAN.md
├── fxmanifest.lua
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
└── web/
    ├── VCR_OSD_MONO_1.001.ttf
    ├── blank.html
    ├── index.html
    ├── main.js
    └── style.css
```

---

## Funcionalidades portadas

- Reproducao de videos YouTube com sincronizacao de tempo
- Reproducao de streams Twitch ao vivo
- Sistema de broadcast ao vivo (canais globais)
- Navegador web interativo com cursor customizado
- Volume por distancia e por jogador
- Numeracao de canais estilo VCR
- Filtro de URLs por palavras proibidas
- Sistema de aprovacao de interacoes via callbacks
- Spawn/despawn de props de TV em locations pré-definidos (OneSync)
- Auto-deteccao de 18 modelos de props de TV/monitor
- Comandos `/tv` e `/broadcast`
- Cleanup automático na desconexao do jogador

---

## Notas tecnicas

- O `ui_page` aponta para `web/blank.html` (HTML transparente). O conteudo e renderizado exclusivamente via DUI nos props 3D.
- A dependencia `Renderer` e um recurso separado que fornece a funcionalidade de renderizacao DUI em props 3D via scaleforms.
- `Config.Locations` requer OneSync habilitado no servidor.
- Os eventos de rede usam o prefixo `ptelevision:` para manter compatibilidade com a API original.
- O NUI callback URL foi atualizado para `https://mri_tv/pageLoaded` (hardcoded no `web/main.js` pois o JS nao tem acesso ao resource name).
