export PATH=/usr/local/bin:$PATH
export EDITOR='/usr/bin/vim'
alias gitk="/usr/bin/wish $(which gitk)"

set -o vi

NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# OPAM configuration
. /Users/niklasi/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

