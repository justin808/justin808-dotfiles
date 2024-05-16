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
#export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

export PATH="/usr/local/opt/llvm/bin:$PATH"

eval "$(asdf exec direnv hook zsh)"

autoload -U add-zsh-hook

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
