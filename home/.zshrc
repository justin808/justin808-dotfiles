echo Loading .zshrc

export PUB_DOTFILES=$HOME/dotfiles/justin808-dotfiles/zsh
export PRIV_DOTFILES=$HOME/dotfiles/private-dotfiles/zsh


source $PRIV_DOTFILES/priv-init-first.zsh

# These are generally useful and open for public sharing.
source $PUB_DOTFILES/init.zsh

# These are either private or not commonly needed.
source $PRIV_DOTFILES/priv-init.zsh
echo Done loading .zshrc



# https://forum.shakacode.com/t/catalina-ruby-error-threads/1800
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
export PATH="/usr/local/opt/llvm/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

echo Loading YVM
export YVM_DIR=/Users/justin/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
