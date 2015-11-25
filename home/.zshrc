export PUB_DOTFILES=$HOME/dotfiles/justin808-dotfiles/zsh
export PRIV_DOTFILES=$HOME/dotfiles/private-dotfiles/zsh

# These are generally useful and open for public sharing.
source $PUB_DOTFILES/init.zsh

# These are either private or not commonly needed.
source $PRIV_DOTFILES/init.zsh
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

export NVM_DIR="/Users/justin/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

