



# Overrides
USER="Odz"
export EDITOR=vim

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
alias cdp="cd '$ODJ_PDIR'"
export ODJ_PDIR="$HOME/proj"

# ls
# use coreutils ls if available
# hash gls >/dev/null 2>&1 || alias gls="ls"
ls='ls -G'
l='ls -lah'
la='ls -lAh'
ll='ls -lh'
lsa='ls -lah'

# git
alias g='git'
alias cdgr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias gitv='git log --graph --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
# git commit browser. needs fzf
glog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

# FZF
fq() {
  fzf -q "$@"
}

# More FZF <3 Git
[ -f ~/.fzf/.functions ] && source ~/.fzf/.functions

# Shorts
alias vi="vim"
alias v="vim"
vq() {
  $EDITOR `$@`
}
alias ctags="`brew --prefix`/bin/ctags"
alias ci="code-insiders"
alias cia="code-insiders -a"
# add alias field = aws print %1
alias strip-ht="col -xb"
alias vimrc="$EDITOR ~/.vim/vimrc"
alias zshrc="$EDITOR ~/.zshrc"
alias bashrc="$EDITOR ~/.bashrc"

# Enhanced
alias tre="tree -F -L 1"
alias cl="clear"
export FZF_DEFAULT_OPTS="--height 80%"

# One liner Utils
alias toplain="perl -pe 's/\x1b\[[0-9;]*[mG]//g'"


# @PualIrish
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


# Go Lang
export GOPATH="$HOME/.golang"
export PATH="$PATH:$GOPATH/bin"
export GOROOT="$(brew --prefix golang)/libexec"

# ADB
export PATH="$PATH:/Users/Odz/Library/Android/sdk/platform-tools"

# MacOS
alias afk="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"

# FZF and fd
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude .git'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Cucumber console color
export CUCUMBER_COLORS=comment=white
