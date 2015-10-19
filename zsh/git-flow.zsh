# Functions for git flow.
# Note, these depend on standard git aliases loaded by zsh.

# gf = Git Flow

# f = Feature
# h = Hotfix
# r = Release

# s = start
# f = finish

# gffs => git flow feature start
# gfff => git flow feature finish

alias gfn=gitFlowNameForCurrentBranch

# Version for git-flow
alias gf-git-cleanup-merged-branches='git branch --merged develop | grep -v develop | xargs git branch -d'

git_current_branch() {
  git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///'
}

gitFlowNameForCurrentBranch() {
  # next line using sed is greedy
  # git_current_branch | sed -e 's/.*\///'
  # This is the non-greedy match
  git_current_branch | perl -pe "s|.*?/||"
}

gup_develop() {
    current_branch="$(git_current_branch)"
    echo current_branch is $current_branch
    gco develop && gup && gco "$current_branch"
}

gup_master() {
    current_branch="$(git_current_branch)"
    echo current_branch is $current_branch
    gco master && gup && gco "$current_branch"
}

gup_develop_master() {
    gup_develop && gup_master
}

gffs() {
  feature=`sanitize $1`
  gup_develop_master && echoRun "git flow feature start -F --showcommands $feature"
}

gffp() {
  feature=`sanitize $1`
  gup_develop_master && echoRun "git flow feature publish --showcommands $feature"
}

gfff() {
  gup_develop_master && echoRun "git flow feature finish -F --showcommands $(gitFlowNameForCurrentBranch)" &&
        echo "Confirm merge and then push develop" || echo "Examine error messages!"
}

gfrs() {
  release=`sanitize $1`
  gup_develop_master && echoRun "git flow release start -F --showcommands $release"
}

gfrp() {
  release=`sanitize $1`
  gup_develop_master && echoRun "git flow release publish -F --showcommands $release"
}

# Changed to
# 1. Be sure to sync up remotes and pull --rebase
# 2. Not push
gfrf() {
    gup_develop_master && echoRun "git flow release finish -Fn --showcommands $(gitFlowNameForCurrentBranch)" &&
        echo "Confirm merge and then push master" || echo "Examine error messages!"
}

gfhs() {
  release=`sanitize $1`
  gup_develop_master && echoRun "git flow hotfix start -F --showcommands $release"
}

gfhp() {
  release=`sanitize $1`
  gup_develop_master && echoRun "git flow hotfix publish --showcommands $release"
}

# 1. sync up remotes and pull --rebase
# 2. do not push when completed, so you have a chance to abort if things did not go smoothly
gfhf() {
  gup_develop_master && echoRun "git flow hotfix finish -Fn --showcommands $(gitFlowNameForCurrentBranch)" &&
        echo "Confirm merge and then push master and develop" || echo "Examine error messages!"
}

