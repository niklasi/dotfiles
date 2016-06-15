if [ -f ~/.bashrc ] ; then
	source ~/.bashrc
fi

# OPAM configuration
. /Users/niklasi/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true
