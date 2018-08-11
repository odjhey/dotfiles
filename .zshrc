# Odjhey
# https://github.com/odjhey/dotfiles
# Mostly from failbowl https://github.com/garybernhardt/dotfiles/

export ZSH=/Users/Odz/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Initialize Advance Prompt Support
setopt PROMPT_SUBST
autoload -U promptinit
promptinit
prompt odz

# Initialize completion
autoload -U compinit
compinit -D

# Add Paths
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"

# better history
export HISTSIZE=100000
export HISTFILE="$HOME/.history"
export SAVEHIST=$HISTSIZE

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

. ~/.profile

