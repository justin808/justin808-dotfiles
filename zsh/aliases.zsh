# be sure to run 'npm install --global pure-prompt' to get pure-prompt
alias screencast-prompt='autoload -U promptinit; promptinit && prompt pure && export RPROMPT=${return_code}$(git_prompt_status)'

# alias beg='bundle exec guard'
alias ber='bundle exec rake'
alias check_vbox='ps -eaf | grep VB*'
alias dz='. ~/.zshrc'
alias e='emacsclient -c'
alias ec='emacsclient -n'
alias enw='emacsclient -nw'
alias g='grep -i --color=auto'
alias h='history'
alias kill_postgres_connections='ps xa | grep postgres: | grep bpos | grep -v grep | awk "{print $1}" | sudo xargs kill'
alias l='exa'
alias les='less -XFRf'
alias les='less -XFRf'
alias ll='ls -alF'
alias mem='memcached -vv'
alias t='tail'
alias tmuxp="tmux -S /var/tmux/1"
alias tp='export TOP=`pwd`'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# One line per part of path, easier to read
alias echopath='echo $PATH | tr : "\n"'

# Updates pretty much everything
alias update_all='sudo softwareupdate -i -a; brew update; brew upgrade; brew cleanup; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update; upgrade_oh_my_zsh'

alias update-packages='(rm npm-shrinkwrap.json || echo "no npm-shrinkwrap.json to remove") && ncu -u -a'
alias nfuck='rm -rf node_modules && npm cache clear && npm i'
alias update-node='nvm install stable && nvm alias default stable'

alias redomigration="rails db:rollback && rails db:migrate && rails db:rollback RAILS_ENV=test && rails db:migrate RAILS_ENV=test"
alias migrate="rails db:migrate && RAILS_ENV=test rails db:migrate"

# https://github.com/yarnpkg/yarn/issues/6453#issuecomment-498110933
alias fix-spotlight="find . -path '*node_modules/*' -prune -o -type d -name 'node_modules' -exec touch '{}/.metadata_never_index' \;"
alias fix-spotlight-globally="find ~ -type d -path './.*' -prune -o -path './Pictures*' -prune -o -path './Library*' -prune -o -path '*node_modules/*' -prune -o -type d -name 'node_modules' -exec touch '{}/.metadata_never_index' \; -print"