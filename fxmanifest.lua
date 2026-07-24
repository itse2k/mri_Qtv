fx_version "cerulean"
game "gta5"

lua54 "yes"

author "Patroa Developer"
description "Sistema de televisao interativa para FiveM"
version "1.0.0"

ui_page "web/blank.html"

files {
    "web/blank.html",
    "web/index.html",
    "web/style.css",
    "web/main.js",
    "web/VCR_OSD_MONO_1.001.ttf",
}

shared_scripts {
    "@ox_lib/init.lua",
    "shared/*.lua",
}

client_scripts {
    "client/*.lua",
}

server_scripts {
    "server/*.lua",
}
