
# Overrides
USER="Odz"

# rm, cp, mv
alias mv="mv -v"
alias cp="cp -v"
alias rm="rm -v"

# git
alias groot='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'
alias gitl='git log --format=oneline'
alias gits='git status'
# git commit browser. needs fzf
glog() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` \
      --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
}

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
export FZF_DEFAULT_OPTS="--height 80%"

# One liner Utils
alias toplain="perl -pe 's/\x1b\[[0-9;]*[mG]//g'"


# @PualIrish
# who is using the laptop's iSight camera?
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
export FZF_DEFAULT_COMMAND='fd --type f --hidden'
# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

