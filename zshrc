# ~/.zshrc configuration file - OPTIMIZED VERSION
# Performance improvements: lazy loading, conditional sourcing, reduced plugin count

# =============================================================================
#                                   Variables
# =============================================================================
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
export TERM="xterm-256color"
export EDITOR="nvim"

# FZF configuration
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --inline-info --color=dark,bg+:235,hl+:10,pointer:5'
export FZF_COMPLETION_TRIGGER='~~'
export FZF_COMPLETION_OPTS='--border --info=inline'

# Improved less options
export LESS="--tabs=4 --no-init --LONG-PROMPT --ignore-case --quit-if-one-screen --RAW-CONTROL-CHARS"

# Catppuccin Mocha colors for exa
export EXA_COLORS="ur=38;5;250:uw=38;5;203:ux=38;5;151:ue=38;5;151:gr=38;5;145:gw=38;5;203:gx=38;5;151:tr=38;5;102:tw=38;5;203:tx=38;5;151:su=38;5;234;48;5;203:sf=38;5;234;48;5;203:xa=38;5;102:*.7z=38;5;216:*.tar=38;5;216:*.zip=38;5;216:*.gz=38;5;216:*.bz2=38;5;216:*.xz=38;5;216:*.jpg=38;5;218:*.jpeg=38;5;218:*.png=38;5;218:*.gif=38;5;218:*.svg=38;5;218:*.mp4=38;5;218:*.mkv=38;5;218:*.avi=38;5;218:*.mp3=38;5;152:*.wav=38;5;152:*.flac=38;5;152:*.ogg=38;5;152:*.pdf=38;5;222:*.doc=38;5;222:*.txt=38;5;189:*.md=38;5;189:*.py=38;5;117:*.js=38;5;117:*.html=38;5;203:*.css=38;5;117:*.json=38;5;222:*.yml=38;5;222:*.sh=38;5;151:*.gitignore=38;5;102"

# =============================================================================
#                              Performance Optimizations
# =============================================================================
# Skip global compinit for faster startup
skip_global_compinit=1

# Disable update checks for oh-my-zsh
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

# =============================================================================
#                                Essential Functions
# =============================================================================
# Lazy load function wrapper
lazy_load() {
    local func_name="$1"
    local load_cmd="$2"
    
    eval "$func_name() {
        unfunction $func_name
        $load_cmd
        $func_name \"\$@\"
    }"
}

# Lazy FZF completion generators (only load when needed)
_fzf_compgen_path() {
    fd --hidden --follow --exclude ".git" . "$1" 2>/dev/null || find "$1" -type f 2>/dev/null
}

_fzf_compgen_dir() {
    fd --type d --hidden --follow --exclude ".git" . "$1" 2>/dev/null || find "$1" -type d 2>/dev/null
}

ZPLUG_ENABLE=1

# =============================================================================
#                              Essential Plugins Only
# =============================================================================
# Install zplug only if it doesn't exist and is actually used
if [[ ! -d ~/.zplug ]] && [[ -n "$ZPLUG_ENABLE" ]]; then
    git clone https://github.com/zplug/zplug ~/.zplug
fi

# Essential plugins that are always loaded for good UX
# These 3 plugins are critical for modern shell experience
if [[ -d ~/.zplug ]] || [[ -n "$ZPLUG_ENABLE" ]]; then
    # Ensure zplug exists
    [[ ! -d ~/.zplug ]] && git clone https://github.com/zplug/zplug ~/.zplug
    source ~/.zplug/init.zsh
    
    # ALWAYS load these essential plugins (fast mode)
    zplug 'zplug/zplug', hook-build:'zplug --self-manage'
    zplug "zsh-users/zsh-autosuggestions"
    zplug "zsh-users/zsh-syntax-highlighting", defer:2
    
    # Additional plugins only when explicitly enabled
    if [[ -n "$ZPLUG_ENABLE" ]]; then
        zplug "Aloxaf/fzf-tab"
        
        # OS-specific (only if commands exist)
        if [[ $OSTYPE == darwin* ]] && (( $+commands[brew] )); then
            zplug "plugins/brew", from:oh-my-zsh
        fi
        
        # Essential oh-my-zsh plugins
        zplug "plugins/git", from:oh-my-zsh, if:"(( $+commands[git] ))"
        zplug "plugins/extract", from:oh-my-zsh
    fi
    
    # Load plugins (with timeout to prevent hanging)
    if ! zplug check --verbose; then
        echo "Missing plugins detected. Run: zplug install"
    else
        zplug load
    fi
else
    # Fallback: Manual syntax highlighting setup if zplug not available
    if [[ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    elif [[ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    elif [[ -f /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]]; then
        source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    fi
    
    # Fallback: Manual autosuggestions if available
    if [[ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    elif [[ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    elif [[ -f /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]]; then
        source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    fi
fi

# =============================================================================
#                                   Options
# =============================================================================
# Key timeout and character sequences
KEYTIMEOUT=1

# History configuration (optimized)
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=$HISTSIZE

# Essential options only
setopt autocd                   # Allow changing directories without `cd`
setopt hist_ignore_dups         # Ignore consecutive duplicates
setopt hist_ignore_all_dups     # Remember only one unique copy of the command
setopt hist_reduce_blanks       # Remove superfluous blanks
setopt hist_ignore_space        # Ignore commands that start with space
setopt extended_glob            # Extended globbing capabilities
setopt share_history            # Share history across sessions
setopt append_history           # Append to history file
setopt inc_append_history       # Append immediately, not at shell exit

# =============================================================================
#                              Essential Aliases (exa-powered)
# =============================================================================
# exa aliases (modern ls replacement with colors, icons, and git integration)
if (( $+commands[exa] )); then
    # Basic exa aliases
    alias ls='exa --color=auto --group-directories-first'
    alias ll='exa -l --icons --git --group-directories-first'
    alias la='exa -la --icons --git --group-directories-first'
    alias l='exa -F --color=auto --group-directories-first'
    alias lt='exa --tree --level=2 --icons'
    alias llt='exa -l --tree --level=2 --icons --git'
    
    # Advanced exa aliases
    alias lx='exa -lbhHigUmuSa@ --time-style=long-iso --git --color-scale --icons'  # Ultimate listing
    alias lS='exa -1 --icons --git --group-directories-first'                        # One column
    alias lr='exa -R --icons --git --group-directories-first'                        # Recursive
    alias lg='exa -l --git --git-ignore --icons --group-directories-first'           # Git status focused
    alias tree='exa --tree --icons --git'                                           # Tree view
else
    # Fallback to traditional ls if exa not available
    alias ll='ls -alF'
    alias la='ls -A'  
    alias l='ls -CF'
fi
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# Git aliases (if git exists)
if (( $+commands[git] )); then
    alias gs='git status'
    alias ga='git add'
    alias gc='git commit'
    alias gp='git push'
    alias gl='git pull'
fi

# Editor aliases
alias vim='nvim'
alias vi='nvim'

# =============================================================================
#                              Lazy Loading Setup
# =============================================================================
# Lazy load SSH/GPG agents (only when needed)
lazy_load setup_agents 'setup_agents_real'
setup_agents_real() {
    if (( $+commands[keychain] )); then
        local -a ssh_keys gpg_keys
        for i in ~/.ssh/**/*pub(.N); do 
            [[ -f "${i:r}" ]] && ssh_keys+=("${i:r}")
        done
        gpg_keys=$(gpg -K --with-colons 2>/dev/null | awk -F : '$1 == "sec" { print $5 }')
        if (( $#ssh_keys > 0 )) || (( $#gpg_keys > 0 )); then
            eval $(keychain --quiet --eval --inherit any-once --agents ssh,gpg $ssh_keys ${(f)gpg_keys})
        fi
    fi
}

# Lazy load FZF (only when first used)
if (( $+commands[fzf] )); then
    lazy_load __fzf_history__ 'source <(fzf --zsh)'
    lazy_load _fzf_complete 'source <(fzf --zsh)'
fi

# =============================================================================
#                              Path Configuration
# =============================================================================
# Add personal scripts to path (if directories exist)
[[ -d "$HOME/bin" ]] && export PATH="$HOME/bin:$PATH"
[[ -d "$HOME/.dotfiles/scripts" ]] && export PATH="$PATH:$HOME/.dotfiles/scripts"
[[ -d "$HOME/.local/bin" ]] && export PATH="$HOME/.local/bin:$PATH"
[[ -d "$HOME/.local/share/zellij" ]] && export PATH="$HOME/.local/share/zellij:$PATH"

# =============================================================================
#                          Conditional Source Loading
# =============================================================================
# Source additional configuration files (only if they exist)
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_rclocal ]] && source ~/.zsh_rclocal
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Nix configuration (only if exists)
[[ -e /home/mjonyh/.nix-profile/etc/profile.d/nix.sh ]] && source /home/mjonyh/.nix-profile/etc/profile.d/nix.sh

# Local environment (only if exists)
[[ -e "$HOME/.local/bin/env" ]] && source "$HOME/.local/bin/env"

# =============================================================================
#                              Prompt Setup (Starship Only)
# =============================================================================
# Initialize starship prompt (optimized for fast startup)
if (( $+commands[starship] )); then
    eval "$(starship init zsh)"
else
    # Lightweight fallback prompt if starship not available
    PS1='%F{cyan}%n@%m%f:%F{green}%~%f$ '
fi

# =============================================================================
#                              Completion Setup
# =============================================================================
# Lazy load completion system
lazy_load compinit '_setup_completions'
_setup_completions() {
    autoload -Uz compinit
    # Only update completions cache once per day for performance
    if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
        compinit -d ~/.zcompdump
    else
        compinit -C -d ~/.zcompdump
    fi
}

# Basic completion styling
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Enable vi mode
bindkey -v

# vim: ft=zsh
