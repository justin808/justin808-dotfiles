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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
# export PATH="$PATH:$HOME/.rvm/bin"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Stuff to put back in
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
    local node_version="$(nvm version)"
    local nvmrc_path="$(nvm_find_nvmrc)"

    if [ -n "$nvmrc_path" ]; then
        local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

        if [ "$nvmrc_node_version" = "N/A" ]; then
            nvm install
        elif [ "$nvmrc_node_version" != "$node_version" ]; then
            nvm use
        fi
        yvm use
    elif [ "$node_version" != "$(nvm version default)" ]; then
        echo "Reverting to nvm default version"
        nvm use default
    fi
}
add-zsh-hook chpwd load-nvmrc

export YVM_DIR=/Users/justin/.yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh
