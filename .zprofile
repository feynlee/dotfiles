source ~/.keys
source ~/.zshrc
source ~/.zshenv

# export JAVA_HOME=$(/usr/libexec/java_home)
# export PATH=/Library/Frameworks/GDAL.framework/Programs:$PATH

# automount Digital Ocean miniprojects - Dataincubator
# sudo sshfs vagrant@vagrant:/home/vagrant/miniprojects/ -o IdentityFile=~/.ssh/dataincubator,reconnect,local,allow_other,defer_permissions ~/tmp/sshfs


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Applications/Anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Applications/Anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Applications/Anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Applications/Anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/ziyue/Code/exec -l /bin/bash/google-cloud-sdk/path.bash.inc' ]; then . '/Users/ziyue/Code/exec -l /bin/bash/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/ziyue/Code/exec -l /bin/bash/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/ziyue/Code/exec -l /bin/bash/google-cloud-sdk/completion.bash.inc'; fi
