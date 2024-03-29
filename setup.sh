#!/bin/sh
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/dotfiles                    # dotfiles directory
files="zshrc vim vimrc gitconfig tmux.conf yabairc config/nvim config/karabiner config/alacritty ideavimrc"    # list of files/folders to symlink in homedir

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

# Brewfile should not be a hidden file
if [ ! -L ~/Brewfile ]; then
    echo "Creating symlink to Brewfile in home directory."
    ln -s Brewfile ~/Brewfile
fi
ls -l ~/Brewfile


# install fzf 
# [ ! -d ~/.fzf ] && git clone https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all

echo "setup complete..."
