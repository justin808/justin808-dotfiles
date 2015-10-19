export PUB_DOTFILES=$HOME/dotfiles/justin808-dotfiles/zsh
export PRIV_DOTFILES=$HOME/dotfiles/private-dotfiles/zsh

# Place any env variables that the public one depends on.
source $PRIV_DOTFILES/init-vars.zsh

# These are generally useful and open for public sharing.
source $PUB_DOTFILES/init.zsh

# These are either private or not commonly needed.
source $PRIV_DOTFILES/init.zsh
