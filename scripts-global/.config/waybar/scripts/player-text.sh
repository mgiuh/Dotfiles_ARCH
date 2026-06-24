#!/bin/bash

# Monitorear cambios usando playerctl
playerctl --follow metadata --format '{{status}}::{{artist}}::{{title}}' 2>/dev/null | while read -r line; do
    # Separar las variables de forma segura
    STATUS=$(echo "$line" | cut -d':' -f1)
    ARTIST=$(echo "$line" | cut -d':' -f3) # El delimitador es ::
    TITLE=$(echo "$line" | cut -d':' -f5)

    # Si no hay nada sonando
    if [ -z "$TITLE" ]; then
        echo '{"text": "Sin música", "class": "stopped"}'
    else
        # Usamos jq para construir el JSON de forma 100% segura
        jq -nc --arg txt "$ARTIST - $TITLE" --arg cls "$STATUS" \
            '{"text": $txt, "class": $cls}'
    fi
done
