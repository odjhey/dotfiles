
# Overrides
USER="Odz"

# Shorts
alias vi="vim"
alias ctags="`brew --prefix`/bin/ctags"
alias ci="code-insiders"
alias cia="code-insiders -a"
# add alias field = aws print %1
alias strip-ht="col -xb"
alias vimrc="vim ~/.vim/vimrc"
alias zshrc="vim ~/.zshrc"
alias bashrc="vim ~/.bashrc"

# Enhanced
alias tre="tree -F -L 1"
alias cl="clear"
alias fzf="fzf --height 50%"

# One liner Utils
alias toplain="perl -pe 's/\x1b\[[0-9;]*[mG]//g'"

# Go Lang
export GOPATH="$HOME/.golang"
export PATH="$PATH:$GOPATH/bin"
export GOROOT="$(brew --prefix golang)/libexec"

# ADB
export PATH="$PATH:/Users/Odz/Library/Android/sdk/platform-tools"
