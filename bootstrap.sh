#!/bin/bash
export CODE_HOME="$HOME/Code"
export DOTFILES_HOME="$CODE_HOME/dotfiles"
export DOTFILES_PRIVATE_HOME="$CODE_HOME/dotfiles_private"

if [[ ! -d $DOTFILES_PRIVATE_HOME ]]; then
	echo "$DOTFILES_PRIVATE_HOME! Please get dotfiles_private before executing bootstrap.sh."
	exit 1
fi

ln -sf $DOTFILES_PRIVATE_HOME/.keys ~
ln -sf $DOTFILES_PRIVATE_HOME/.ssh ~
ln -sf $DOTFILES_PRIVATE_HOME/.aws ~
ln -sf $DOTFILES_PRIVATE_HOME/ftp-key.asc ~

ln -sf $DOTFILES_HOME/.bash_profile ~
ln -sf $DOTFILES_HOME/.bashrc ~
ln -sf $DOTFILES_HOME/.vimrc ~
ln -sf $DOTFILES_HOME/.gitconfig ~
ln -sf $DOTFILES_HOME/.vim ~
ln -sf $DOTFILES_HOME/.tmux ~
ln -sf $DOTFILES_HOME/.jupyter ~

# brew install
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
cd $DOTFILES_HOME
brew bundle

# install anaconda
wget https://repo.continuum.io/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh -O ~/anaconda3.sh
bash ~/anaconda3.sh -b -p /Applications/anaconda3
rm ~/anaconda3.sh
export PATH="Applications/anaconda3/bin:$PATH" >> ~/.bashrc
# use conda to install all python packages
conda install -y nb_conda_kernels
conda env create -f $DOTFILES_HOME/environment.yml

# jupyter configuration
# touch ~/.jupyter/jupyter_notebook_config.py
# echo "c.NotebookApp.open_browser = False" >> ~/.jupyter/jupyter_notebook_config.py


source ~/.bash_profile

echo "==> All done!"
