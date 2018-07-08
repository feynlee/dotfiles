export AWS_PROFILE="default"
export CODE_HOME="$HOME/Code"
export DOTFILES_HOME="$HOME/Code/dotfiles"
export DOTFILES_PRIVATE_HOME="$HOME/Code/dotfiles_private"
export BASH_HOME="$DOTFILES_HOME/bash"
export PATH=~/usr/local/Cellar:/usr/local/bin:/usr/local/sbin:~/bin:~/.local/bin/:$PATH

alias  bp="vim ~/.bash_profile"
alias  rc="vim ~/.bashrc"
alias  ep="vim $BASH_HOME/module_python_spark.sh"
alias  ew="vim $BASH_HOME/module_work.sh"
alias  ev="vim $BASH_HOME/module_vim.sh"
alias  eg="vim $BASH_HOME/module_git.sh"
alias  er="vim $BASH_HOME/module_ruby.sh"
alias  et="vim $BASH_HOME/module_tmux.sh"
alias  so=". ~/.bash_profile"

alias  setup_tmux="vim ~/.tmux/data-tmux"

alias  first="cd $CODE_HOME/Data_analysis/First"
alias  data="cd $CODE_HOME/Data_analysis; Jupyter notebook"
alias  code="cd $CODE_HOME"
alias  dot="cd $DOTFILES_HOME"
alias  dotp="cd $DOTFILES_PRIVATE_HOME"
alias  site="cd ~/Documents/code/sites"
alias  model="cd $CODE_HOME/Data_analysis/First/predictive-model"
alias  nmodel="cd $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li"
alias  batch="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/lib/_resources/Batch_list.csv"
alias  combine="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/_resources/Combine_list.csv"
alias  mixbatch="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/_resources/Mix_scoring_list.csv"
alias  mrfolder="cd $CODE_HOME/Data_analysis/First/java-mapreduce"
alias  mrcode="cd $CODE_HOME/Data_analysis/First/java-mapreduce/src/main/java/io/first/mapreduce"
alias  cleanup="cd $CODE_HOME/Data_analysis/First/csv_clean_up"
alias  import="cd $CODE_HOME/Data_analysis/First/data_pipeline/Import_score"
alias  spark="cd $CODE_HOME/Data_analysis/First/spark/"
alias  vesta="cd $CODE_HOME/Data_analysis/First/vesta/"
alias  cortex="cd $CODE_HOME/Data_analysis/First/cortex/"
alias  pipeline="cd $CODE_HOME/Data_analysis/First/pipeline/"
alias  davinci="cd $CODE_HOME/Data_analysis/First/davinci/"
alias  analysis="cd $CODE_HOME/Data_analysis/First/data_analysis/"
alias  lead="cd $CODE_HOME/Data_analysis/First/list_scoring_projects/"
#eval "$(thefuck --alias fuck)"

# source other files
source ~/.keys
for f in $DOTFILES_HOME/bash/*.sh; do source $f; done

# added by Anaconda3 5.1.0 installer
export PATH="/Applications/anaconda3/bin:$PATH"
