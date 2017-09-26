#!/bin/bash

###########################
# This script creates symlinks from main workspace/home directory# to the corresponding dotfile in dotfiles repo
###########################

#### Variables ####

dir=~/dotfiles                  # dotfiles directory
olddir=~/dotfiles_old           # old dotfiles backup directory
files="vimrc"                             # list of files/folders to symlink in homedir


###################


# Create new folder "/dotfiles_old" in homedir
echo -n "Creating $olddir for backup of existing dotfiles ..."
mkdir -p $olddir
echo "done"

# Change to dotfiles directory
echo -n "Changing to $dir directory ..."
cd $dir
echo "done"

for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file $olddir/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# Download vim-plug to ~/.vim if it isn't present

if [ ! -e ~/.vim/autoload/plug.vim ]; then
    echo "Could not detect vim-plug in autoload..."
    echo "Downloading vim-plug to ./vim/autoload..."
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    echo "done"
fi
