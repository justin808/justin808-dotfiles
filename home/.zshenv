export PATH="$HOME/.jenv/bin:$PATH"
export PUB_DOTFILES=$HOME/dotfiles/justin808-dotfiles/zsh
export PRIV_DOTFILES=$HOME/dotfiles/private-dotfiles/zsh
export ZSH_CUSTOM=$PUB_DOTFILES/oh-my-zsh-custom
export ZSH=$HOME/.oh-my-zsh
export ZSH_THEME="justin808"
export EDITOR=vim

# Place any env variables that the public one depends on.
source $PRIV_DOTFILES/init-vars.zsh
