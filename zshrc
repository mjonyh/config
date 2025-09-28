# ~/.zshrc configuration file

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

# =============================================================================
#                                   Functions  
# =============================================================================
# FZF completion generators
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'tree -C {} | head -200'   "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview 'bat -n --color=always {}' "$@" ;;
  esac
}

# =============================================================================
#                                   Plugins
# =============================================================================
# Install zplug if not already installed
[ ! -d ~/.zplug ] && git clone https://github.com/zplug/zplug ~/.zplug
source ~/.zplug/init.zsh

# Core plugins
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug "jocelynmallon/zshmarks"
zplug "supercrabtree/k"
zplug "tarrasch/zsh-bd"
zplug "arzzen/calc.plugin.zsh"
zplug "seebi/dircolors-solarized", ignore:"*", as:plugin
zplug "Aloxaf/fzf-tab"
zplug "hlissner/zsh-autopair", defer:2
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search"

# Oh-My-Zsh plugins
zplug "plugins/common-aliases",    from:oh-my-zsh
zplug "plugins/colored-man-pages", from:oh-my-zsh
zplug "plugins/copydir",           from:oh-my-zsh
zplug "plugins/copyfile",          from:oh-my-zsh
zplug "plugins/cp",                from:oh-my-zsh
zplug "plugins/dircycle",          from:oh-my-zsh
zplug "plugins/encode64",          from:oh-my-zsh
zplug "plugins/extract",           from:oh-my-zsh
zplug "plugins/tmux",              from:oh-my-zsh
zplug "plugins/web-search",        from:oh-my-zsh
zplug "plugins/z",                 from:oh-my-zsh
zplug "plugins/fancy-ctrl-z",      from:oh-my-zsh
zplug "plugins/django",            from:oh-my-zsh
zplug "plugins/vi-mode",           from:oh-my-zsh

# OS-specific plugins
if [[ $OSTYPE = (linux)* ]]; then
    zplug "plugins/archlinux",     from:oh-my-zsh, if:"(( $+commands[pacman] ))"
    zplug "plugins/dnf",           from:oh-my-zsh, if:"(( $+commands[dnf] ))"
fi

if [[ $OSTYPE = (darwin)* ]]; then
    zplug "lib/clipboard",         from:oh-my-zsh
    zplug "plugins/osx",           from:oh-my-zsh
    zplug "plugins/brew",          from:oh-my-zsh, if:"(( $+commands[brew] ))"
    zplug "plugins/macports",      from:oh-my-zsh, if:"(( $+commands[port] ))"
    alias python=python3
fi

# Command-specific plugins
zplug "plugins/git",               from:oh-my-zsh, if:"(( $+commands[git] ))"
zplug "plugins/node",              from:oh-my-zsh, if:"(( $+commands[node] ))"
zplug "plugins/npm",               from:oh-my-zsh, if:"(( $+commands[npm] ))"
zplug "plugins/pip",               from:oh-my-zsh, if:"(( $+commands[pip] ))"
zplug "plugins/sudo",              from:oh-my-zsh, if:"(( $+commands[sudo] ))"
zplug "plugins/gpg-agent",         from:oh-my-zsh, if:"(( $+commands[gpg-agent] ))"
zplug "plugins/systemd",           from:oh-my-zsh, if:"(( $+commands[systemctl] ))"

# =============================================================================
#                                   Options
# =============================================================================
# Key timeout and character sequences
KEYTIMEOUT=1
WORDCHARS='*?_-[]~=./&;!#$%^(){}<>'

# System monitoring
watch=(notme)        # Report login/logout events for everybody except ourself
LOGCHECK=60          # Time (seconds) between checks for login/logout activity
REPORTTIME=5         # Display usage statistics for commands running > 5 sec

# History configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=$HISTSIZE

# Directory navigation
setopt autocd                   # Allow changing directories without `cd`
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist
setopt hist_find_no_dups        # Don't display duplicates during searches
setopt hist_ignore_dups         # Ignore consecutive duplicates
setopt hist_ignore_all_dups     # Remember only one unique copy of the command
setopt hist_reduce_blanks       # Remove superfluous blanks
setopt hist_save_no_dups        # Omit older commands in favor of newer ones
setopt hist_ignore_space        # Ignore commands that start with space
setopt pushd_ignore_dups        # Don't push copies of the same dir on stack
setopt pushd_minus              # Reference stack entries with "-"
setopt extended_glob            # Extended globbing capabilities

# =============================================================================
#                                   Aliases
# =============================================================================
# Directory coloring
if [[ $OSTYPE = (darwin|freebsd)* ]]; then
    export CLICOLOR="YES" # Equivalent to passing -G to ls
    export LSCOLORS="exgxdHdHcxaHaHhBhDeaec"

    [ -d "/opt/local/bin" ] && export PATH="/opt/local/bin:$PATH"

    # Prefer GNU version, since it respects dircolors
    if (( $+commands[gls] )); then
        alias ls='() { $(whence -p gls) -Ctr --file-type --color=auto $@ }'
    else
        alias ls='() { $(whence -p ls) -CFtr $@ }'
    fi
else
    alias ls='() { $(whence -p ls) -Ctr --file-type --color=auto $@ }'
fi

# Use nvim if available
if (( $+commands[nvim] )); then
    alias vim='() { $(whence -p nvim) $@ }'
else
    alias vim='() { $(whence -p vim) $@ }'
fi

# Generic command adaptations
alias grep='() { $(whence -p grep) --color=auto $@ }'
alias egrep='() { $(whence -p egrep) --color=auto $@ }'

# Directory management
alias la='ls -a'
alias ll='ls -l'
alias lal='ls -al'
alias d='dirs -v'
alias pu='() { pushd $1 &> /dev/null; dirs -v; }'
alias po='() { popd &> /dev/null; dirs -v; }'

# Custom helper aliases
alias ccat='highlight -O ansi'
alias rm='rm -vr'
alias md='mkdir -p'
alias djpyman="python3 manage.py"
alias finalquestion="cp ~/git/lecture/{question_template.tex,sustlogo.png} . && mv question_template.tex "

# Directory number shortcuts
for index ({1..9}); do
    alias "$index"="pu -$index"
done

# =============================================================================
#                                Key Bindings
# =============================================================================
# Common CTRL bindings
bindkey "^a" beginning-of-line
bindkey "^e" end-of-line
bindkey "^f" forward-word
bindkey "^b" backward-word
bindkey "^k" kill-line
bindkey "^d" delete-char
bindkey "^y" accept-and-hold
bindkey "^w" backward-kill-word
bindkey "^u" backward-kill-line

# Do not require a space when attempting to tab-complete
bindkey "^i" expand-or-complete-prefix

# Fixes for alt-backspace and arrows keys
bindkey '^[^?' backward-kill-word
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[A" up-line-or-search
bindkey "^[[B" down-line-or-search

# Word movement behaviors
tcsh-backward-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle emacs-backward-word
}
zle -N tcsh-backward-word
bindkey '\e[1;3D' tcsh-backward-word
bindkey '\e^[[D' tcsh-backward-word # tmux

tcsh-forward-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle emacs-forward-word
}
zle -N tcsh-forward-word
bindkey '\e[1;3C' tcsh-forward-word
bindkey '\e^[[C' tcsh-forward-word # tmux

tcsh-backward-delete-word () {
  local WORDCHARS="${WORDCHARS:s#./#}"
  zle backward-delete-word
}
zle -N tcsh-backward-delete-word
bindkey "^[^?" tcsh-backward-delete-word # urxvt

# =============================================================================
#                                 Completions
# =============================================================================
# Add deno completions to search path
if [[ ":$FPATH:" != *":/home/mjonyh/.zsh/completions:"* ]]; then 
    export FPATH="/home/mjonyh/.zsh/completions:$FPATH"
fi

zstyle ':completion:*' rehash true
zstyle ":completion:*" matcher-list \
  "m:{a-zA-Z}={A-Za-z}" \
  "r:|[._-]=* r:|=*" \
  "l:|=* r:|=*"

zstyle ":completion:*:default" list-colors ${(s.:.)LS_COLORS}

# =============================================================================
#                                   Startup
# =============================================================================
# Load SSH and GPG agents via keychain
setup_agents() {
  [[ $UID -eq 0 ]] && return

  if (( $+commands[keychain] )); then
    local -a ssh_keys gpg_keys
    for i in ~/.ssh/**/*pub; do test -f "$i(.N:r)" && ssh_keys+=("$i(.N:r)"); done
    gpg_keys=$(gpg -K --with-colons 2>/dev/null | awk -F : '$1 == "sec" { print $5 }')
    if (( $#ssh_keys > 0 )) || (( $#gpg_keys > 0 )); then
      alias run_agents='() { $(whence -p keychain) --quiet --eval --inherit any-once --agents ssh,gpg $ssh_keys ${(f)gpg_keys} }'
      unalias run_agents
    fi
  fi
}

setup_agents
unfunction setup_agents

# # Set up FZF if installed
# if [ -f ~/.fzf.zsh ]; then
#   source ~/.fzf.zsh
# elif [ -f /usr/share/fzf/key-bindings.zsh ] && [ -f /usr/share/fzf/completion.zsh ]; then
#   source /usr/share/fzf/key-bindings.zsh
#   source /usr/share/fzf/completion.zsh
# fi

# Install plugins if needed
if ! zplug check; then
    printf "Install plugins? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Configure dircolors if available
if zplug check "seebi/dircolors-solarized"; then
  which gdircolors &> /dev/null && alias dircolors='() { $(whence -p gdircolors) }'
  which dircolors &> /dev/null && \
      eval $(dircolors ~/.zplug/repos/seebi/dircolors-solarized/dircolors.256dark)
fi

# Enable vi mode
bindkey -v

# Configure history substring search
if zplug check "zsh-users/zsh-history-substring-search"; then
    zmodload zsh/terminfo
    bindkey "$terminfo[kcuu1]" history-substring-search-up
    bindkey "$terminfo[kcud1]" history-substring-search-down
    bindkey "^[[1;5A" history-substring-search-up
    bindkey "^[[1;5B" history-substring-search-down
fi

# Syntax highlighting configuration
if zplug check "zsh-users/zsh-syntax-highlighting"; then
    ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor line)
    ZSH_HIGHLIGHT_PATTERNS=('rm -rf *' 'fg=white,bold,bg=red')

    typeset -A ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[cursor]='bg=yellow'
    ZSH_HIGHLIGHT_STYLES[globbing]='none'
    ZSH_HIGHLIGHT_STYLES[path]='fg=white'
    ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=grey'
    ZSH_HIGHLIGHT_STYLES[alias]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[builtin]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[function]='fg=cyan'
    ZSH_HIGHLIGHT_STYLES[command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'
    ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=green'
    ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=yellow'
    ZSH_HIGHLIGHT_STYLES[redirection]='fg=magenta'
    ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=cyan,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=green,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=magenta,bold'
    ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=yellow,bold'
fi

# Load plugins
zplug load

# Set up FZF
source <(fzf --zsh)

# Add personal scripts to path
[ -d "$HOME/bin" ] && export PATH="$HOME/bin:$PATH"
export PATH=$PATH:$HOME/.dotfiles/scripts/

# Source additional configuration files
[[ -f ~/.zsh_functions ]] && source ~/.zsh_functions
[[ -f ~/.zsh_rclocal ]] && source ~/.zsh_rclocal
[[ -f ~/.zsh_exports ]] && source ~/.zsh_exports
[[ -f ~/.zsh_aliases ]] && source ~/.zsh_aliases

# Initialize starship prompt
eval "$(starship init zsh)"

# Nix configuration 
if [ -e /home/mjonyh/.nix-profile/etc/profile.d/nix.sh ]; then 
    . /home/mjonyh/.nix-profile/etc/profile.d/nix.sh
fi

# Initialize atuin shell history
if [ -e "$HOME/.local/bin/env" ]; then
    . "$HOME/.local/bin/env"
fi

# vim: ft=zsh
export PATH="$HOME/.local/share/zellij:$PATH"
