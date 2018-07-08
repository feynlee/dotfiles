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
cd $DOTFILES_HOME


# setup Vundle for vim
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# install plugins via vim + vundle
vim +PluginInstall +qall
# compile ycm (this has to happen before brew installs python,
# so that it's using the correctly linked system python)
cd ~/.vim/bundle/YouCompleteMe
./install.py
# install airline fonts
cd ~
git clone https://github.com/powerline/fonts.git --depth=1
cd ~/fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts


# brew install the rest of the packages
cd $DOTFILES_HOME
brew bundle
source ~/.bash_profile


# install anaconda
if [[ ! -f ~/anaconda3.sh ]]; then
	cd ~
	wget https://repo.continuum.io/archive/Anaconda3-5.1.0-MacOSX-x86_64.sh -O ~/anaconda3.sh
	bash ~/anaconda3.sh -b -p /Applications/Anaconda3
	rm ~/anaconda3.sh
fi
# export PATH="Applications/anaconda3/bin:$PATH" >> ~/.bashrc
# use conda to install all python packages
conda install -y nb_conda_kernels
conda env create -f $DOTFILES_HOME/environment.yml
conda install pyspark
# install notebook extensions
pip install --upgrade pip
pip install jupyter_contrib_nbextensions
jupyter contrib nbextension install --user

# install spark
wget -O


source ~/.bash_profile

echo "==> All done!"
