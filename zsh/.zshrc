# --- 1. CONFIGURACIÓN DE ENTORNO Y VARIABLES ---
export ZSH="$HOME/.oh-my-zsh"
export EDITOR='nvim'
export VISUAL='nvim'
export HISTFILE=~/.cache/zsh_history

# --- 2. OPCIONES DE SHELL ---
setopt AUTO_CD
setopt HIST_IGNORE_DUPS
setopt INC_APPEND_HISTORY
HISTSIZE=5000
SAVEHIST=5000

# --- 3. OH MY ZSH (NÚCLEO OPTIMIZADO) ---
ZSH_THEME="" 
DISABLE_AUTO_UPDATE="true"
plugins=(git zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# --- 4. AUTOCOMPLETADO (Optimizado con caché) ---
autoload -Uz compinit
compinit -i -C -d "$HOME/.cache/zsh/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# --- CONFIGURACIÓN DE HERRAMIENTAS ADICIONALES ---
alias ls='eza --icons --group-directories-first'
alias ll='eza -lh --icons --group-directories-first'

bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# --- 5. ALIASES ---

# --- 5. ALIASES ---

# Pacman (Prefijo 'p')
alias pi='sudo pacman -S' # Instalar paquete
alias pu='sudo pacman -Syu' # Actualizar sistema
alias pr='sudo pacman -Rns' # Eliminar paquete y dependencias
alias pl='sudo pacman -Qdtq' # Listar huérfanos [cite: 1]

# AUR (Prefijo 'a')
alias ai='yay -S' # Instalar desde AUR
alias au='yay -Syu' # Actualizar sistema + AUR
alias ar='yay -Rns' # Eliminar paquete AUR
alias ac='yay -Sc' # Limpiar caché de yay [cite: 1, 2]

# Flatpak (Prefijo 'f')
alias fi='flatpak install' # Instalar flatpak
alias fu='flatpak update' # Actualizar flatpaks
alias fr='flatpak uninstall' # Desinstalar flatpak
alias fl='flatpak list' # Listar aplicaciones
alias fc='flatpak uninstall --unused' # Limpiar residuos [cite: 1]

# Sistema y Niri
alias conf='nvim ~/.config/niri/config.kdl' # Configuración de Niri [cite: 1]
alias barconf='nvim ~/.config/waybar/config.jsonc' # Configuración de Waybar [cite: 1]
alias zconf='nvim ~/.zshrc' # Editar este archivo [cite: 1]
alias in='fastfetch' # Información del sistema [cite: 1]
alias poweroff='sudo poweroff' # Apagar equipo [cite: 1]
alias freetube='~/.local/bin/freetube-software' # Abrir FreeTube [cite: 1]

# Buscar alias específicos rápido
alias ga='alias | grep' # Buscar un alias interactivo
alias la='misalias' # Mostrar este mapa de alias

# --- 6. FUNCIONES ---
# Ver tus alias organizados estéticamente con descripciones
misalias() {
    echo -e "\n\e[1;212m  󰘵  MAPA DE ALIAS CONFIGURADOS \e[0m"
    awk '
    /^# [A-Z]/ {
        section=$0; 
        sub(/^# /, "", section); 
        print "\n\033[1;111m󰿟 " section "\033[0m"
    } 
    /^alias / {
        # Separar el comentario (descripción) si existe
        desc = "";
        if (match($0, /#[[:space:]]*.+$/)) {
            desc = substr($0, RSTART);
            sub(/^#[[:space:]]*/, "", desc);
            $0 = substr($0, 1, RSTART-1);
        }
        
        # Procesar el alias y el comando
        split($0, a, "="); 
        sub(/^alias /, "", a[1]); 
        sub(/[[:space:]]+$/, "", a[1]); # Limpia espacios al final del alias
        gsub(/\x27/, "", a[2]); # Quita comillas simples
        sub(/[[:space:]]+$/, "", a[2]); # Limpia espacios al final del comando
        
        # Formato de salida de columnas: Alias (amarillo) | Comando (blanco) | Descripción (gris/cyan oscuro)
        printf "  \033[1;149m%-10s\033[0m %-40s \033[0;90m# %s\033[0m\n", a[1], a[2], (desc ? desc : "Sin descripción")
    }' ~/.zshrc
    echo ""
}

# --- 6. PROMPT Y EJECUCIÓN FINAL ---
PROMPT='%F{111} %f %F{149}%~%f %F{212}➜ %f '
fastfetch

# --- 7. PATHS Y ENTORNO ---
export PATH=/home/diego-xir/.opencode/bin:$PATH
export PATH="$PATH:/home/diego-xir/.local/bin"
export PATH=~/.npm-global/bin:$PATH

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
