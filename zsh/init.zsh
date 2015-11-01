export ZSH_CUSTOM=$PUB_DOTFILES/oh-my-zsh-custom
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="justin808"
export EDITOR=vim

plugins=(git gitfast git-extras last-working-dir)

# Per instructions from zsh install
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles
source $ZSH/oh-my-zsh.sh

bindkey -v
bindkey '^[[A' up-line-or-search
bindkey '^[[B' down-line-or-search
bindkey '^R' history-incremental-search-backward
bindkey '^F' history-incremental-search-forward
bindkey "\e[3~" delete-char
bindkey " " magic-space # do history expansion on space
bindkey "^G" history-search-backward
bindkey "^S" history-search-forward
bindkey '[C' forward-word
bindkey '[D' backward-word

setopt extended_glob
# http://parley.rubyrogues.com/t/migrating-from-bash-to-zsh/1532/4
autoload -U zmv

# Order matters
source $PUB_DOTFILES/aliases.zsh
source $PUB_DOTFILES/utility.zsh
source $PUB_DOTFILES/rails.zsh
source $PUB_DOTFILES/octopress.zsh

source $PUB_DOTFILES/git.zsh
source $PUB_DOTFILES/git-flow.zsh


# for now, this is required for capybara-webkit
export QMAKE=/usr/local/Cellar/qt5/5.5.1/bin/qmake

# https://github.com/github/hub
eval "$(hub alias -s)"
