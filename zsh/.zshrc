export EDITOR='/usr/local/bin/nvim'
export VISUAL='/usr/local/bin/nvim'
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]='none'

zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

bindkey -v
bindkey '^r' history-incremental-search-backward
bindkey '^j' history-search-forward
bindkey '^k' history-search-backward
bindkey '^[[Z' autosuggest-accept

autoload -U compinit && compinit

HISTSIZE=1000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu no
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

zstyle ':fzf-tab:*' use-fzf-default-opts yes
export FZF_DEFAULT_OPTS="--prompt=' '\
    --bind shift-up:preview-up,shift-down:preview-down\
    --color=gutter:-1,bg+:#3B4252,spinner:#81A1C1,hl:#616E88,fg:#D8DEE9,header:#616E88,info:#5E81AC,pointer:#81A1C1,marker:#B48EAD,fg+:#D8DEE9,prompt:#81A1C1,hl+:#81A1C1" 

# zstyle ':fzf-tab:complete:(cd|ls):*' fzf-preview --height '100%' 'tree -L 3 -C $realpath | head -200'
zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
# Theme colors from arcticicestudio/nord-vim
# some more ls aliases
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

alias vim='nvim'
alias vi='nvim'
alias nvo='nvim $(fzf -m --preview="batcat --color=always --style=numbers --line-range=:500 {}")'

eval "$(starship init zsh)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
