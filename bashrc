export PATH=${PATH}:/Developer/SDKs/android-sdk-mac_86/tools

# MacPorts Installer addition on 2010-07-08_at_23:13:55: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export EDITOR='/usr/bin/vim'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
alias gitk="/usr/bin/wish $(which gitk)"

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
export TERM="xterm-256color"
