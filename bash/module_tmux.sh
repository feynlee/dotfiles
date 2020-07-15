export PATH=$PATH:$HOME/.tmux:~/App_build

# TMUX: auto setup tmux session when log in
if which tmux >/dev/null 2>&1; then
	#if not inside a tmux session, and if no session is started, start a new session
	test -z "$TMUX" && (tmux attach || tmux-home)
fi

#####
# auto set up tmux session - test
# tmux new -s test
# tmux send-keys "jupyter notebook" "c-m"
# tmux rename-window "Jupyter"
# tmux new-window
# tmux send-keys "cd ~/Desktop" "c-m"
# tmux rename-window "Desktop"