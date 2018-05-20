recompile_ycm() {
	cd ~/.vim/bundle/YouCompleteMe
	/usr/local/bin/python2 ./install.py --clang-completer
}