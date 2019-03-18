export DEFAULT_RUBY=ruby-2.4.1
export DEFAULT_GEMSET=rails5

# This allows the use of [] without escapes
alias rake='noglob rake'

create-ruby() {
  RUBY_VERSION=${1-${DEFAULT_RUBY}}
  RUBY_GEMSET=${2-${DEFAULT_GEMSET}}
  # RUBY_VERSION=${1-ruby-2.0.0-p247}
  # RUBY_GEMSET=${2-rails4}
  echo $RUBY_VERSION >| .ruby-version
  echo $RUBY_GEMSET >| .ruby-gemset
  cd ..
  cd -
  echo "Created .ruby-version and .ruby_gemset. Version: '$RUBY_VERSION', gemset: '$RUBY_GEMSET'"
}

alias rvmp='rvm-prompt'
alias bp='export PATH=$PWD/bin:$PATH'
alias gig='rvm @global do gem install $1'

export PROCESSES_TO_QUIT='chromedriver puma rake sidekiq spring rails$ ruby-debug phantomjs zeus passenger guard resque "node server.js" ruby$ node foreman fsevent_wat'

pgr() {
    echo "Finding processes in list: $PROCESSES_TO_QUIT"
    echo $PROCESSES_TO_QUIT | xargs -n 1 pgrep -l
}

pgk() {
    echo "Killing processes in list: $PROCESSES_TO_QUIT"
    echo $PROCESSES_TO_QUIT | xargs -n 1 pkill -l
}

ZEUS_SOCK=/Users/justin/clients/blink/bpos/.zeus.sock

pgkk() {
    echo "Killing -9 processes in list: $PROCESSES_TO_QUIT"
    echo $PROCESSES_TO_QUIT | xargs -n 1 pkill -9 -l
    if [[ -a ${ZEUS_SOCK} ]]; then
        rm ${ZEUS_SOCK}
        echo Removed ${ZEUS_SOCK}
    fi
}

rspec-say() {
    rspec $@
    say "r spec test completed"
}

update-all() {
    echo "bundle && cd client && yarn && cd .. && rake db:migrate && rake db:migrate RAILS_ENV=test"
    bundle && cd client && yarn && cd .. && rake db:migrate && rake db:migrate RAILS_ENV=test
}
