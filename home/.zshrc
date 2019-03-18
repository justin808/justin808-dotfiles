echo Loading .zshrc

export PUB_DOTFILES=$HOME/dotfiles/justin808-dotfiles/zsh
export PRIV_DOTFILES=$HOME/dotfiles/private-dotfiles/zsh

export HOME_HOST=justin-2017mbp.local

source $PRIV_DOTFILES/priv-init-first.zsh

# These are generally useful and open for public sharing.
source $PUB_DOTFILES/init.zsh

# These are either private or not commonly needed.
source $PRIV_DOTFILES/priv-init.zsh
echo Done loading .zshrc


export YVM_DIR=/Users/justin/.yvm
[ -r $YVM_DIR/yvm.sh ] && source $YVM_DIR/yvm.sh
