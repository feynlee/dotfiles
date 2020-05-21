source ~/.bash_prompt

export AWS_PROFILE="default"
export CODE_HOME="$HOME/Code"
export DOTFILES_HOME="$HOME/Code/dotfiles"
export BASH_HOME="~/bash"
export PATH=~/usr/local/Cellar:/usr/local/bin:/usr/local/sbin:~/bin:~/.local/bin/:$PATH

alias  bp="vim ~/.bash_profile"
alias  rc="vim ~/.bashrc"
alias  eg="vim ~/bash_customization-home_general.sh"
alias  ew="vim ~/bash_customization-home_work.sh"
alias  so=". ~/.bash_profile"

alias  setup_tmux="vim ~/.tmux/tmux-home"

alias  first="cd $CODE_HOME/Data_analysis/First"
alias  data="cd $CODE_HOME/Data_analysis; Jupyter notebook"
alias  code="cd $CODE_HOME"
alias  dot="cd $DOTFILES_HOME"
alias  doth="cd $DOTFILES_HOME/dotfiles_home"
alias  dotp="cd $DOTFILES_HOME/dotfiles_private"
alias  dott="cd $DOTFILES_HOME/dotfiles_tools_li"
alias  dotf="cd $DOTFILES_HOME/first_secrets"
alias  site="cd ~/Code/sites"
alias  model="cd $CODE_HOME/Data_analysis/First/predictive-model"
alias  nmodel="cd $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li"
alias  batch="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/lib/_resources/Batch_list.csv"
alias  combine="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/_resources/Combine_list.csv"
alias  mixbatch="vim $CODE_HOME/Data_analysis/First/predictive-model/ipython/New_model-Ziyue_Li/_resources/Mix_scoring_list.csv"
alias  secrets="vim ~/.davinci/secrets.yaml"
alias  keys="vim ~/.keys"
alias  mrfolder="cd $CODE_HOME/Data_analysis/First/java-mapreduce"
alias  mrcode="cd $CODE_HOME/Data_analysis/First/java-mapreduce/src/main/java/io/first/mapreduce"
alias  cleanup="cd $CODE_HOME/Data_analysis/First/csv_clean_up"
alias  import="cd $CODE_HOME/Data_analysis/First/data_pipeline/Import_score"
alias  spark="cd $CODE_HOME/Data_analysis/First/spark/"
alias  vesta="cd $CODE_HOME/Data_analysis/First/vesta/"
alias  cortex="cd $CODE_HOME/Data_analysis/First/cortex/"
alias  ecr="cd $CODE_HOME/Data_analysis/First/ECR_images/"
alias  pipeline="cd $CODE_HOME/Data_analysis/First/pipeline/"
alias  davinci="cd $CODE_HOME/Data_analysis/First/davinci/"
alias  davinci_dev="cd $CODE_HOME/Data_analysis/First/davinci_dev/"
alias  analysis="cd $CODE_HOME/Data_analysis/First/data_analysis/"
alias  de="cd $CODE_HOME/Data_analysis/First/data_engineering/"
alias  lead="cd $CODE_HOME/Data_analysis/First/list_scoring_projects/"
alias  state_machine="cd $CODE_HOME/Data_analysis/First/state_machines_ds/"
alias  aug="cd $CODE_HOME/Data_analysis/First/augment-services/"
alias  auto="cd $CODE_HOME/Data_analysis/First/automation-services/"
alias  glue="cd $CODE_HOME/Data_analysis/First/glue-scripts/"
#eval "$(thefuck --alias fuck)"

# source other files
source ~/.keys
# for f in $BASH_HOME/*.sh; do source $f; done
source ~/bash_customization-home_general.sh
source ~/bash_customization-home_work.sh


# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . /Applications/Anaconda3/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash