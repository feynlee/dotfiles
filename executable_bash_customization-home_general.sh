# TMUX: auto setup tmux session when log in
#if which tmux >/dev/null 2>&1 &&; then
#	if ! tmux has-session -t data >/dev/null 2>&1; then
#		#if not inside a tmux session, and if no session is started, start a new session
#		test -z "$TMUX" && (tmux attach || tmux-home)
#	fi
#fi


# vim mode
# Use vim keys in tab complete menu:
# bindkey -M menuselect 'h' vi-backward-char
# bindkey -M menuselect 'k' vi-up-line-or-history
# bindkey -M menuselect 'l' vi-forward-char
# bindkey -M menuselect 'j' vi-down-line-or-history
# bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
# function zle-keymap-select {
#   if [[ ${KEYMAP} == vicmd ]] ||
# 	       [[ $1 = 'block' ]]; then
#       echo -ne '\e[1 q'
# 	    elif [[ ${KEYMAP} == main ]] ||
# 			       [[ ${KEYMAP} == viins ]] ||
# 				          [[ ${KEYMAP} = '' ]] ||
# 						         [[ $1 = 'beam' ]]; then
# 		    echo -ne '\e[5 q'
# 			  fi
# 		  }
# 	  zle -N zle-keymap-select
# 	  zle-line-init() {
# 	      zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
# 		      echo -ne "\e[5 q"
# 		  }
# 	  zle -N zle-line-init
# 	  echo -ne '\e[5 q' # Use beam shape cursor on startup.
# 	  preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

gemail () {
	git filter-branch --env-filter '
	OLD_EMAIL="$1"
	CORRECT_NAME="Ziyue Li"
	CORRECT_EMAIL="$2"
	if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
	then
		export GIT_COMMITTER_NAME="$CORRECT_NAME"
		export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
	fi
	if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
	then
		export GIT_AUTHOR_NAME="$CORRECT_NAME"
		export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
	fi
	' --tag-name-filter cat -- --branches --tags
}


# convenient functions
gcdot () {
	cwd=$(pwd)
	cd $DOTFILES_HOME/dotfiles_home
	git commit -am '${1}'
	git push
	cd $DOTFILES_HOME/dotfiles_tools_li
	git commit -am '${1}'
	git push
	cd $cwd
}

ldot () {
	cwd=$(pwd)
	cd $DOTFILES_HOME/dotfiles_home
	stow -v -R -t ~ .
	cd $DOTFILES_HOME/dotfiles_tools_li
	stow -v -R -t ~ .
	cd $cwd
}



# FAST.AI
fastai_old () {
	ZONE="us-west2-b" # budget: "us-west1-b"
	INSTANCE_NAME="my-fastai-instance"
	gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080
}

fastai () {
	ZONE="us-east1-c" # budget: "us-west1-b"
	INSTANCE_NAME="my-fastai-instance-2"
	gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080
}

fastai_p () {
	ZONE="us-west1-b" # budget: "us-west1-b"
	INSTANCE_NAME="my-fastai-instance-persistant"
	gcloud compute ssh --zone=$ZONE jupyter@$INSTANCE_NAME -- -L 8080:localhost:8080
	# gcloud beta compute --project "famous-design-243419" ssh --zone "us-west1-b" "my-fastai-instance-persistant" -- -L 8080:localhost:8080

}

fastai_download () {
	ZONE="us-west1-b" # budget: "us-west1-b"
	INSTANCE_NAME="my-fastai-instance-persistant"
	gcloud compute scp $INSTANCE_NAME:$1 $2 --zone $ZONE
  }



# export PATH=/usr/local/opt/openssl/bin:$PATH
