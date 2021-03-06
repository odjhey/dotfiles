# Odjhey
# https://github.com/odjhey/dotfiles
# Mostly from failbowl https://github.com/garybernhardt/dotfiles/

#plugins=(git-flow-completion zsh-syntax-highlighting cf)
#plugins=(zsh-syntax-highlighting cf)

export NVM_LAZY_LOAD=true
plugins=(zsh-nvm zsh-syntax-highlighting cf)

export ZSH=/Users/Odz/.oh-my-zsh
source $ZSH/oh-my-zsh.sh
fpath+=~/.zfunc 

# Initialize Advance Prompt Support
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
#prompt odzmin
prompt odz

# I think Oh-my-zsh has this
## Initialize completion
#autoload -U compinit
#compinit -D

# better history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE
setopt inc_append_history
setopt share_history

# Oh-my-zsh has this
## Use C-x C-e to edit the current command line
#autoload -U edit-command-line
#zle -N edit-command-line
#bindkey '\C-x\C-e' edit-command-line

# By default, zsh considers many characters part of a word (e.g., _ and -).
# Narrow that down to allow easier skipping through words via M-f and M-b.
export WORDCHARS='*?[]~&;!$%^<>'

# Aliases
function mkcd() { mkdir -p $1 && cd $1 }
function cdf() { cd *$1*/ } # stolen from @topfunky

# By @ieure; copied from https://gist.github.com/1474072
#
# It finds a file, looking up through parent directories until it finds one.
# Use it like this:
#
#   $ ls .tmux.conf
#   ls: .tmux.conf: No such file or directory
#
#   $ ls `up .tmux.conf`
#   /Users/grb/.tmux.conf
#
#   $ cat `up .tmux.conf`
#   set -g default-terminal "screen-256color"
#
function up()
{
    local DIR=$PWD
    local TARGET=$1
    while [ ! -e $DIR/$TARGET -a $DIR != "/" ]; do
        DIR=$(dirname $DIR)
    done
    test $DIR != "/" && echo $DIR/$TARGET
}

[ -f ~/.fzf/.fzf.zsh ] && source ~/.fzf/.fzf.zsh

[ -f ~/.profile ] && source ~/.profile

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export PATH="$HOME/.apollo/bin:$PATH"
