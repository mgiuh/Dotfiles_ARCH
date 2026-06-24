#!/bin/bash

# Flags de rendimiento + Forzar Wayland Nativo
FLAGS="--disable-gpu \
--disable-software-rasterizer \
--disable-gpu-sandbox \
--no-sandbox \
--enable-features=UseOzonePlatform \
--ozone-platform=wayland"

flatpak run io.freetubeapp.FreeTube $FLAGS "$@" &>/dev/null &
disown
