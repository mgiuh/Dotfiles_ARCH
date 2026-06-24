
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ==============================================================================
# 0. CONFIGURACIÓN DE OH MY ZSH
# ==============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# ==============================================================================
# CONFIGURACIÓN DE PLUGINS (Los superpoderes de tu terminal)
# ==============================================================================
plugins=(
    git # [Nativo] Atajos cortos para Git (ej: 'gst' para status, 'gcl' para clonar)
 

    sudo # [Nativo] Presiona ESC dos veces para añadir 'sudo' al comando anterior

    zsh-autosuggestions # [Externo] Sugiere comandos en gris basados en tu historial mientras escribes

    zsh-syntax-highlighting # [Externo] Si el comando existe se pone VERDE, si está mal escrito se pone ROJO
 
    zsh-history-substring-search # [Externo] Escribe una palabra, usa flechas ARRIBA/ABAJO y busca esa palabra en el historial

    fzf # [Nativo/Sistema] Activa el menú interactivo difuso (Ctrl+R para historial, Ctrl+T para archivos)

    colored-man-pages # [Nativo] Le añade colores a los manuales ('man comando') para que no sean un bloque gris
)

source $ZSH/oh-my-zsh.sh  # Nota: el script instalador usa 'oh-my-zsh.sh'

# ==============================================================================
# 1. OPCIONES DE HISTORIAL
# ==============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          
setopt HIST_IGNORE_ALL_DUPS

# ==============================================================================
# 2. AUTOCOMPLETADO
# ==============================================================================
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 
zstyle ':completion:*' menu select                       

# ==============================================================================
# 3. ATAJOS DE TECLADO
# ==============================================================================
bindkey -e 
bindkey '^[[H' beginning-of-line 
bindkey '^[[F' end-of-line       
bindkey '^[[3~' delete-char      
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# ==============================================================================
# 4. ALIASES GENERALES (Con eza)
# ==============================================================================
if command -v eza &> /dev/null; then
    alias ls='eza --icons=always --group-directories-first'
    alias la='eza -la --icons=always --group-directories-first --header --git'
    alias ll='eza -l --icons=always --group-directories-first'
    alias lt='eza --tree --level=2 --icons=always'
else
    alias ls='ls --color=auto'
    alias la='ls -la --color=auto'
fi

alias v='nvim'

# ==============================================================================
# 5. INTEGRACIÓN DE RANGER
# ==============================================================================
ranger-cd() {
    local temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if [ -f "$temp_file" ]; then
        local chosen_dir="$(cat "$temp_file")"
        if [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
            cd "$chosen_dir"
        fi
    fi
    rm -f "$temp_file"
}
alias r='ranger-cd'
alias ranger='ranger-cd'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

