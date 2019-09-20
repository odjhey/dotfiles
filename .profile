
#Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Add Paths
export PATH=/usr/local/opt/texinfo/bin:${PATH}
export PATH=/usr/local/sbin:/usr/local/bin:${PATH}
export PATH="$HOME/bin:$PATH"


# TODO add check if has emacs daemon then use emacsclient else use vim
export EDITOR=nvim
export ZVIM=nvim

# custom scripts
export PATH="$PATH:$HOME/bin:$HOME/bin/scripts"

# ruby gems
gembin=`(gem env | sed -n "s/.*EXECUTABLE DIRECTORY: \(.*\)/\1/p")`
export PATH=$gembin:$PATH

# rm, cp, mv
alias mv="mv -v"
alias cp="cp -v"
alias rm="rm -v"

# nav - some of these are already in zsh
alias ..="cd .."
alias cd..="cd .."
alias cd.="cd .."
alias ...="cd ../.."
alias -- -="cd -"
alias cdd="cd $HOME/Desktop"
alias cddl="cd $HOME/Downloads"
alias cdp="cd $HOME/proj"
alias cdft="cd $HOME/Desktop/ftmonorepo"
cdgo() {
  cd "$GOPATH/src/github.com/"
  if ! ( [ -z "$@" ] )
  then 
    cd "$@"
  fi
}

# ls
# use coreutils ls if available
# hash gls >/dev/null 2>&1 || alias gls="ls"
alias ls='ls -G'
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias lsa='ls -lah'
# List only directories
alias lsd="ls -lF -G | grep --color=never '^d'"
alias lsf="ls -lF -G | grep --color=never '^-'"

# git
alias g='git'
alias cdgr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
gitclone() {
    rm -rf `basename $1 .git`
    git clone $1
    cd `basename $1 .git`
    git reset --hard $2
}

# yar
alias y='yarn'

# FZF
fq() {
  fzf -q "$@"
}

# More FZF <3 Git
[ -f ~/.fzf/.functions ] && source ~/.fzf/.functions

# vim
alias vi="$ZVIM"
alias vim="$ZVIM"
alias v="$ZVIM"
alias vipb="pbpaste | vi -"
vq() {
  $EDITOR `$@`
}

# emacs
alias e="emacsclient -c"
alias ec="emacsclient"
alias ecli="emacs -nw"
alias bemacsd="brew services restart emacs-plus"

# shorts
# alias ctags="`brew --prefix`/bin/ctags"
alias ctags="`brew --prefix`/Cellar/ctags/5.8_1/bin/ctags"
alias ci="code-insiders"
alias cia="code-insiders -a"
# add alias field = aws print %1
alias surround="sed -e \"s/\\(.*\\)/'\\1'/\""
alias strip-ht="col -xb"

# fast conf edit
alias vimrc="$EDITOR ~/.vim/vimrc"
alias nvimrc="$EDITOR ~/.config/nvim/init.vim"
alias zshrc="$EDITOR ~/.zshrc"
alias bashrc="$EDITOR ~/.bashrc"

# Enhanced
alias tre="tree -F -L 1"
alias cl="clear"
export FZF_DEFAULT_OPTS="--height 80%"

# One liner Utils
alias toplain="perl -pe 's/\x1b\[[0-9;]*[mG]//g'"

# @PualIrish {{{
# who is using the laptops iSight camera?
camerausedby() {
	echo "Checking to see who is using the iSight camera… 📷"
	usedby=$(lsof | grep -w "AppleCamera\|USBVDC\|iSight" | awk '{printf $2"\n"}' | xargs ps)
	echo -e "Recent camera uses:\n$usedby"
}

# whois a domain or a URL
function whois() {
	local domain=$(echo "$1" | awk -F/ '{print $3}') # get domain from URL
	if [ -z $domain ] ; then
		domain=$1
	fi
	echo "Getting whois record for: $domain …"

	# avoid recursion
					# this is the best whois server
													# strip extra fluff
	/usr/bin/whois -h whois.internic.net $domain | sed '/NOTICE:/q'
}

# Copy w/ progress
cp_p () {
  rsync -WavP --human-readable --progress $1 $2
}
#}}}

# Thanks! https://github.com/junegunn/dotfiles
chist() {
  local cols sep
  export cols=$(( COLUMNS / 3 ))
  export sep='{::}'
  cp -f ~/Library/Application\ Support/Google/Chrome/Default/History /tmp/h
  sqlite3 -separator $sep /tmp/h \
    "select title, url from urls order by last_visit_time desc" |
  ruby -ne '
    cols = ENV["cols"].to_i
    title, url = $_.split(ENV["sep"])
    len = 0
    puts "\x1b[36m" + title.each_char.take_while { |e|
      if len < cols
        len += e =~ /\p{Han}|\p{Katakana}|\p{Hiragana}|\p{Hangul}/ ? 2 : 1
      end
    }.join + " " * (2 + cols - len) + "\x1b[m" + url' |
  fzf --ansi --multi --no-hscroll --tiebreak=index |
  sed 's#.*\(https*://\)#\1#' | xargs open
}

# Viber search using FZF
fzvibe() {
  command cp -f ~/Library/Application\ Support/ViberPC/639154666405/viber.db /tmp/viber.db
  sqlite3 /tmp/viber.db 'select replace( ( messageinfo.body || ">" || contact.clientname || "#" || number ), char(10), " " )
                              from messageinfo 
                              inner join contact 
                                on messageinfo.contactid = contact.contactid
                              and messageinfo.body is not null
                              and messageinfo.body != ""
                              and ( contact.clientname is not null
                                or contact.number is not null 
                                or contact.name is not null
                              )' |
                           uniq |
                           fzf --ansi --multi --no-hscroll --tiebreak=index 
}

# thanks https://unix.stackexchange.com/questions/31414/how-can-i-pass-a-command-line-argument-into-a-shell-script
csv2tab () {
	column -s, -t < $1 | less -#2 -N -S
}

# 
# Mass replace
agr () { ag -0 -l "$1" | xargs -0 perl -pi.bak -e "s/$1/$2/g"; }


# Go Lang
export GOPATH="$HOME/golang"
export PATH="$PATH:$GOPATH/bin"
export GOROOT="$(brew --prefix golang)/libexec"

# ADB
export PATH="$PATH:/Users/Odz/Library/Android/sdk/platform-tools"
export ANDROID_HOME="/Users/Odz/Library/Android/sdk"

# MacOS
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# FZF and fd
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Homebrew
# alias bupdg="brew update && brew upgrade && brew cleanup && brew prune && brew doctor"
alias bupdg="brew update && brew upgrade && brew cleanup && brew doctor && rupstup update"

[ -f ~/safe/.aliases ] && source ~/safe/.aliases
[ -f ~/safe/.functions ] && source ~/safe/.functions

export PATH="$HOME/.cargo/bin:$PATH"

# wireshark
export PATH="$(brew --prefix wireshark)/bin:$PATH"



if [ -f "${HOME}/.gnupg/.gpg-agent-info" ]; then
  . "${HOME}/.gnupg/.gpg-agent-info"
  export GPG_AGENT_INFO
fi

if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi
