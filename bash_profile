if [ -f ~/.bashrc ] ; then
	source ~/.bashrc
fi

# OPAM configuration
. /Users/niklasi/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
