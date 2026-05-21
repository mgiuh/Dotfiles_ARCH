#!/bin/bash

# 1. Tus variables originales exactas
opc_apps="Aplicaciones"
opc_keys="Atajos de teclado"
opc_wall="Wallpaper selector"
opc_power="Power menu"

# 2. Juntar las opciones en una sola lista separada por saltos de línea
menu_opciones="$opc_apps\n$opc_keys\n$opc_wall\n$opc_power"

# 3. Lanzar Rofi en modo dmenu con tu tema horizontal
eleccion=$(echo -e "$menu_opciones" | rofi -dmenu -theme ~/.config/rofi/menu_inicial.rasi -p "Dashboard:")

# 4. Manejar la opción seleccionada con la lógica real de tu sistema
case "$eleccion" in
    "$opc_apps")
        # Abre tu menú de aplicaciones dividido (Fase 3)
        ~/.local/bin/rofi_scripts/launcher.sh
        ;;
        
    "$opc_keys")
        # Extrae tus bindkeys reales de i3wm y los muestra en una lista vertical interactiva
        if [ -f "$HOME/.config/i3/config" ]; then
            grep -E '^bindsym' "$HOME/.config/i3/config" | sed 's/bindsym //' | rofi -dmenu -p "Atajos i3wm:" -theme-str 'window { width: 650px; height: 400px; } mainbox { children: [inputbar, listview]; } listview { layout: vertical; lines: 10; columns: 1; }'
        else
            rofi -e "No se encontró la configuración de i3wm en ~/.config/i3/config"
        fi
        ;;
        
    "$opc_wall")
        # Selector de temas/wallpapers: Lee las imágenes de tu carpeta (Ajusta la ruta si usas otra)
        CARPETA_WALLS="$HOME/Imágenes/Wallpapers"
        if [ -d "$CARPETA_WALLS" ]; then
            WALL_ELEGIDO=$(ls "$CARPETA_WALLS" | rofi -dmenu -p "Seleccionar Fondo:" -theme-str 'window { width: 500px; height: 400px; } mainbox { children: [inputbar, listview]; } listview { layout: vertical; lines: 10; columns: 1; }')
            if [ ! -z "$WALL_ELEGIDO" ]; then
                # Aplica el fondo y regenera los colores con pywal al instante
                wal -i "$CARPETA_WALLS/$WALL_ELEGIDO"
                # Refresca i3wm para aplicar la nueva paleta de colores
                i3-msg restart
            fi
        else
            rofi -e "Por favor crea la carpeta $CARPETA_WALLS con tus imágenes."
        fi
        ;;
        
    "$opc_power")
        # Menú de apagado rápido conectado a systemctl
        ACCION=$(echo -e "Apagar\nReiniciar\nSuspender\nCerrar Sesión" | rofi -dmenu -p "Sistema:" -theme-str 'window { width: 300px; height: 220px; } mainbox { children: [inputbar, listview]; } listview { layout: vertical; lines: 4; columns: 1; }')
        case "$ACCION" in
            "Apagar") systemctl poweroff ;;
            "Reiniciar") systemctl reboot ;;
            "Suspender") systemctl suspend ;;
            "Cerrar Sesión") i3-msg exit ;;
        esac
        ;;
        
    *)
        exit 0
        ;;
esac
