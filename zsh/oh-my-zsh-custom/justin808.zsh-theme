hostname=`hostname`
if [[ $hostname == *"$USER"* ]] && [[ $USER == "justin" ]]; then
  host_stuff=''
else
  echo ">>>> hostname is $hostname and USER is $USER, so using a long prompt"
  host_stuff='%n@%m:'
fi
PROMPT='%{$fg_bold[red]%}➜ %{$fg_bold[green]%}%p ${host_stuff}%{$fg[cyan]%}${PWD/#$HOME/~} %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

# display exitcode on the right when >0
return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

#RPROMPT='${return_code}$(git_prompt_status)%{$reset_color%} [%*]'
# Take out timestamp
RPROMPT='${return_code}$(git_prompt_status)%{$reset_color%}'

# RPROMPT='[%*]'
ZSH_THEME_GIT_PROMPT_PREFIX="(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
GIT_PS1_SHOWUPSTREAM=verbose

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
