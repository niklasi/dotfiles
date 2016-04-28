export PATH=/usr/local/bin:$PATH
export EDITOR='/usr/bin/vim'
export GOPATH=$HOME/dev/go
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
alias gitk="/usr/bin/wish $(which gitk)"
alias vim="mvim -v"

set -o vi

txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # txtred
txtgrn='\e[0;32m' # txtgrn
txtylw='\e[0;33m' # txtylw
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
txtrst='\e[0m'    # Text txtrst

function parse_git_branch {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1) /'
}
function git_status_color {
  local STATUS=`git status 2>&1`
  if [[ "$STATUS" == *'Not a git repository'* ]]
  then
    echo ""
  else
    if [[ "$STATUS" == *'working directory clean'* ]]
    then
      echo -e $txtgrn 
		else
    	if [[ "$STATUS" == *'Untracked files'* ]]
			then
				echo -e $txtred
    	else
				echo -e $txtylw 
    	fi
		fi
  fi
}
PS1=''$txtcyn'\w$(parse_git_branch)'$txtrst'\n$ '
#PS1=''$txtcyn'\w'$txtrst'$(git_status_color)$(parse_git_branch)'$txtrst'\n$ '
# export TERM="screen-256color"

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
