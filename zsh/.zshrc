# --- 1. CONFIGURACIÓN NÚCLEO DE OH MY ZSH ---
export ZSH="$HOME/.oh-my-zsh"

# Tema (Nota: Tu PROMPT personalizado al final sobrescribirá visualmente esto)
ZSH_THEME="robbyrussell"

# Plugins de Oh My Zsh (internos)
plugins=(git)

# Carga de Oh My Zsh
source $ZSH/oh-my-zsh.sh

# --- 2. PLUGINS EXTERNOS (Instalados vía Pacman en Arch) ---
# Se cargan después de OMZ para evitar conflictos
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# --- 2.1 Forzar editor nano para ranger ---
export EDITOR='vim'
export VISUAL='vim'

# --- 2.2 Importar colores de (Pywal) para tu hermosa terminal ---
(cat ~/.cache/wal/sequences &)

# --- 3. OPCIONES DE SHELL ---
setopt AUTO_CD              # Escribe solo el nombre de una carpeta para entrar
setopt HIST_IGNORE_DUPS     # No guarda comandos duplicados seguidos
HISTSIZE=5000
SAVEHIST=5000
# Guardamos el historial en .cache para mantener el HOME limpio
HISTFILE=~/.cache/zsh_history

# --- 4. AUTOCOMPLETADO PRO ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # Ignora mayúsculas

# --- 5. PROMPT PERSONALIZADO (Estilo Arch) ---
# %F{blue} indica el logo de Arch. %~ es la ruta.
PROMPT='%F{blue} %f %F{cyan}%~%f %F{yellow}➜ %f '

# --- 6. MIS ALIAS PERSONALIZADOS ---
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias limpiar='sudo pacman -Rns $(pacman -Qdtq)'
alias conf='vim ~/.config/i3/config'
alias barconf='vim ~/.config/i3blocks/config'
alias zconf='vim ~/.zshrc'
alias n='ranger_cd'  # Un atajo rápido para tu gestor de archivos
alias in='fastfetch'
alias delete='sudo pacman -Rns'
alias poweroff='sudo poweroff'

alias gemini='/home/diego-xir/Escritorio/gemini-app/venv/bin/python /home/diego-xir/Escritorio/gemini-app/main.py'

# Alias para MiniGemini (ajusta la ruta si es necesario)
alias groq='/home/diego-xir/Escritorio/groq-app/venv/bin/python /home/diego-xir/Escritorio/groq-app/main.py'

# Variables para MiniGemini
export GROQ_API_KEY='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'
export ANTHROPIC_API_KEY='tu_llave_de_anthropic_aqui'
export GEMINI_API_KEY='AIzaSyDwEbCAiP7uiabO8qq4NYuhy95Xgvv0u0Q'

fastfetch

ranger_cd() {
    tempfile="$(mktemp -t ranger_cd.XXXXXX)"
    ranger --choosedir="$tempfile" "${@:-$PWD}"
    if test -f "$tempfile"; then
        if [ "$(cat -- "$tempfile")" != "$PWD" ]; then
            cd -- "$(cat "$tempfile")" || return
        fi
    fi
    rm -f -- "$tempfile"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
