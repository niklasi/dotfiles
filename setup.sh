#!/bin/sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
files="zshrc vim vimrc config/nvim gitconfig tmux.conf"    # list of files/folders to symlink in homedir

##########

cd $dir

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    if [ ! -L ~/.$file ]; then
        echo "Creating symlink to $file in home directory."
        ln -s $dir/$file ~/.$file
    fi
    ls -l ~/.$file
done

# install minpac 
[ ! -d vim/pack/minpac/opt/minpac ] && git clone https://github.com/k-takata/minpac.git vim/pack/minpac/opt/minpac

# install fzf 
[ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all

# install oh-my-zsh 
[ ! -d ~/.oh-my-zsh ] && sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# install nvm
[ ! -d ~/.nvm ] && curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.0/install.sh | zsh

echo "setup complete..."
