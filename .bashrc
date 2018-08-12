# Odjhey: Bashrc
# Mostly from failbowl garybernhardt
. ~/bin/bash_colors.sh

# Unbreak broken, non-colored terminal
export TERM='xterm-color'
alias ls='ls -G'
alias l='ls -lG'
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

# Erase duplicates in history
export HISTCONTROL=erasedups
# Store 10k history entries
export HISTSIZE=10000
# Append to the history file when exiting instead of overwriting it
shopt -s histappend

# Git prompt components
function minutes_since_last_commit {
    now=`date +%s`
    last_commit=`git log --pretty=format:'%at' -1`
    seconds_since_last_commit=$((now-last_commit))
    minutes_since_last_commit=$((seconds_since_last_commit/60))
    echo $minutes_since_last_commit
}
odz_git_prompt() {
    local g="$(__gitdir)"
    if [ -n "$g" ]; then
        local MINUTES_SINCE_LAST_COMMIT=`minutes_since_last_commit`
        if [ "$MINUTES_SINCE_LAST_COMMIT" -gt 60 ]; then
            local COLOR=${RED}
        elif [ "$MINUTES_SINCE_LAST_COMMIT" -gt 30 ]; then
            local COLOR=${YELLOW}
        else
            local COLOR=${GREEN}
        fi
        local SINCE_LAST_COMMIT="${COLOR}$(minutes_since_last_commit)${NORMAL}"
        # The __git_ps1 function inserts the current git branch where %s is
        local GIT_PROMPT=`__git_ps1 "(${BRIGHT_WHITE}%s${BLACK}|${SINCE_LAST_COMMIT})"`
        echo ${GIT_PROMPT}
    fi
}
PS1="${GREEN}\h:${NORMAL}\W${RESET}"
PS1+="\$(odz_git_prompt) ${BRIGHT_YELLOW}\$${RESET} "

miniprompt() {
  unset PROMPT_COMMAND
  PS1="\[\e[38;5;168m\]> \[\e[0m\]"
}

# Completion
source ~/bin/git-completion.bash
eval "$(pandoc --bash-completion)"

[ -f ~/.fzf/.fzf.bash ] && source ~/.fzf/.fzf.bash

. ~/.profile

