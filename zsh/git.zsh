alias gpthis='git push origin HEAD:$(git_current_branch) && git branch -u origin/$(git_current_branch) $(git_current_branch) && echo "pushed current branch and set upstream to origin"'
alias gh='git log --name-status -n'
alias gcom='gco master'
alias hb='hub browse'

# Override the default zsh one: https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/git/git.plugin.zsh
# so that --no-ff
alias gm='git merge --no-ff'

# This has a major issue in that it doesn't abort if there's nothing to stash,
# and then it unstashes the last stash.
alias gupp='echo "stashing, gup, and stash popping" && git stash && gup && git stash pop'

alias git-diff-master-develop='git log --left-right --graph --cherry-pick master..develop'

# Version for typical branches off of master
alias git-cleanup-merged-branches='git branch --merged master | grep -v master | xargs git branch -d'

alias git-cleanup-origin='git remote prune origin'

alias git-cleanup-octopress-merged-branches='git branch --merged source | grep -v source | grep -v master | xargs git branch -d'

alias git-refresh-upstream='gco master && git fetch upstream && git merge upstream/master'

git-branch-current() {
    printf "%s\n" $(git branch 2> /dev/null | grep -e ^* | tr -d "\* ")
}

# https://gist.github.com/590895
git-log-last-pushed-hash() {
    local currentBranch=$(git-branch-current);
    git log --format="%h" -n 1 origin/${currentBranch}
}

git-rebase-unpushed() {
    git rebase --interactive $(git-log-last-pushed-hash)
}

gitk_everything() {
    gitk --all --date-order $(git log -g --pretty=%H)
}

git-list-remote-branches-to-remove() {
    git branch -r --merged | grep 'origin/' | grep -v "origin/master$" | grep -v "origin/develop$" | sed 's/\s*origin\///'
}

git-list-remote-branches-to-remove-do-it() {
    git-list-remote-branches-to-remove | xargs -n 1 git push --delete origin
}

git-file-diffs() {
    git log -p $@
}

git-find-commit() {
    git log -S $@ --source --all
}
