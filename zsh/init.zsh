export ZSH_CUSTOM=$PUB_DOTFILES/oh-my-zsh-custom
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="justin808"
export EDITOR=vim

echo Loading ZSH Plugins
# https://github.com/lukechilds/zsh-nvm#auto-use
export NVM_AUTO_USE=true

plugins=(
    git
    gitfast
    git-extras
    last-working-dir
)

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
# IMPORTANT -- this needs updating whenever updating qt5
# AND maybe only qt5.5. is supported:
# https://github.com/thoughtbot/capybara-webkit/wiki/Installing-Qt-and-compiling-capybara-webkit#macos-sierra-1012-el-capitan-1011-and-yosemite-1010
export QMAKE=/usr/local/Cellar/qt@5.5/5.5.1_1/bin/qmake

# https://github.com/github/hub
eval "$(hub alias -s)"

# See https://dev.to/_darrenburns/10-tools-to-power-up-your-command-line-4id4?utm_source=Newsletter+Subscribers&utm_campaign=d83390372e-EMAIL_CAMPAIGN_2019_01_07_06_59&utm_medium=email&utm_term=0_d8f11d5d1e-d83390372e-147568685
. /usr/local/etc/profile.d/z.sh

 [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

