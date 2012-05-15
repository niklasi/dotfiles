export PATH=${PATH}:/Developer/SDKs/android-sdk-mac_86/tools
##
# Your previous /Users/niklas/.bash_profile file was backed up as /Users/niklas/.bash_profile.macports-saved_2010-07-08_at_23:13:55
##

# MacPorts Installer addition on 2010-07-08_at_23:13:55: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=~/bin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.
export EDITOR='/usr/bin/vim'
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm"  # This loads RVM into a shell session.
alias gitk="/usr/bin/wish $(which gitk)"
txtred='\033[0;31m' 
txtgrn='\033[0;32m' 
txtylw='\033[1;33m' 
end='\033[0m' 

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
      echo -e '\033[032m'
		else
    	if [[ "$STATUS" == *'Untracked files'* ]]
			then
      	echo -e '\033[031m'
    	else
				echo -e '\033[33m'
    	fi
		fi
  fi
}

#PS1='[\W$(parse_git_branch)]\$ ' 
#	PS1='\u $'
#else
PS1='\[\033[37m\w\033[0m\]\[$(git_status_color)$(parse_git_branch)\033[0m\]
$ '
#fi
