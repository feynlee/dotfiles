export FIRST_HOME="$CODE_HOME/Data_analysis/First"
export DAVINCI_HOME="$CODE_HOME/Data_analysis/First/davinci"
export VESTA_HOME="$CODE_HOME/Data_analysis/First/vesta"
export DATA_HOME="$CODE_HOME/Data_analysis/First/data"

export PYTHONPATH=$HOME/Local_installations/miniforge3:/Applications/Anaconda3:$PYTHONPATH
export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
export PYTHONIOENCODING="utf-8"
export PYTHONDONTWRITEBYTECODE=""

# export JAVA_HOME="$(/usr/libexec/java_home -v 1.8)"
# export SPARK_HOME=/Applications/App_build/spark-2.4.3-bin-hadoop2.8

export HOMEBREW_OPT="/usr/local/opt"
export JAVA_HOME=$HOMEBREW_OPT/openjdk@11
export SPARK_HOME=$HOMEBREW_OPT/apache-spark/libexec
export PYTHONPATH=$SPARK_HOME/python:$SPARK_HOME/python/lib/py4j-0.10.9.5-src.zip:$PYTHONPATH
export PATH=$JAVA_HOME/bin:$SPARK_HOME/bin:$PYTHONPATH:$PATH
export PATH=$PATH:~/App_build

export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
export PYSPARK_PYTHON="/Applications/Anaconda3/envs/py39/bin/python"
export SFN_DIR="/Users/ziyue/Code/Data_Analysis/First/state_machines_ds"

alias hstart="/usr/local/Cellar/hadoop/2.6.0/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/2.6.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/2.6.0/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/2.6.0/sbin/stop-dfs.sh"
alias zepstart="~/App_build/zeppelin-0.7.1-bin-all/bin/zeppelin-daemon.sh start"
alias zepstop="~/App_build/zeppelin-0.7.1-bin-all/bin/zeppelin-daemon.sh stop"

# data
first_lftp () {
	# lftp -p 22 -u $CI_FTP_USERNAME,$CI_FTP_PASSWORD sftp://sfgext.acxiom.com
	lftp -p 22 -u $ftp_username,$ftp_password sftp://sfgext.acxiom.com
}

get_premover() {
	# /Applications/anaconda3/envs/py27/bin/python $FIRST_HOME/pipeline/premover/premover_download_upload.py $1 $2
	conda deactivate
	conda activate py310
	python $FIRST_HOME/vesta/scripts/data_processing/premover_download_upload.py $1 $2
	conda deactivate
}

sync_score_importing_scripts() {
	$FIRST_HOME/augment-services/resources/emr/predictive-addresses/make_and_upload_files.sh
}


exec_vesta_pipeline() {
	conda deactivate
	conda activate py310
	python $FIRST_HOME/automation-services/vesta_pipeline/scripts/exec_vesta_pipeline.py "$@"
}

load_scored_data_to_predictive_addresses() {
	conda deactivate
	conda activate py310
	which python
	python $FIRST_HOME/automation-services/vesta_pipeline/scripts/import_scores.py "$@"
	conda deactivate
}

ebi_test() {
	conda activate py39
	python $FIRST_HOME/ebi-elt/scripts/build_image.py
	python $FIRST_HOME/ebi-elt/scripts/start_container.py
}

presign_url() {
	aws s3 presign --expires-in 604800 $1
}

# sync
# update docs on Heroku
sync_to_heroku () {
	git subtree push --prefix docs/ heroku master
}

# update_code_versions() {
# 	aws s3 cp ~/Code/Data_Analysis/First/vesta/experiment_versions/code_versions.json s3://first-io-datalake-production/data/output/vesta/experiments_metadata/code_versions.json
# }

update_config() {
	cd $FIRST_HOME/vesta/tasks
	conda activate py39
	python $FIRST_HOME/vesta/scripts/tasks/Make_config_tables.py
	conda deactivate
}


sync_spark() {
	conda activate py39
	# sync vesta folder
	aws s3 sync $FIRST_HOME/vesta/ s3://first-io-datalake-production/user/Li/code/vesta/ --exclude "*.git/*" --exclude ".idea/*" --delete
	# zip davinci package
	cd $FIRST_HOME/davinci/
	rm davinci.zip
	zip -r davinci.zip davinci
	# sync davinci package
	aws s3 sync $FIRST_HOME/davinci/ s3://first-io-datalake-production/user/Li/code/davinci/ --exclude "*.git/*" --exclude ".idea/*" --exclude "__pycache__/*" --exclude "*.pyc" --exclude "*.DS_Store" --delete
	# sync serects
	aws s3 cp $HOME/.davinci/secrets.yaml s3://first-io-datalake-production/user/Li/code/.davinci/secrets.yaml
	# generate and sync config table
	update_config()
	cd ~
}


sync_brainy_flat_table_to_athena() {
	python2 $FIRST_HOME/pipeline/sync_brainy/Sync_agents_data_and_create_Athena_table.py
}

upload_spark() {
	aws s3 cp $FIRST_HOME/spark/src/main/Pyspark_2.0/ s3://predictive-model/code/Li/Spark_national_model/ --recursive
}

sync_reports() {
	conda deactivate
	source activate py3
	jupyter nbconvert --ExecutePreprocessor.kernel_name=python --to html --execute $FIRST_HOME/data_analysis/index.ipynb --output $FIRST_HOME/data_analysis/reports/index.html --template=report.tpl
	conda deactivate
	aws s3 sync $FIRST_HOME/data_analysis/reports s3://first-io-data-analysis/data_science --include "*.html" --exclude "*.DS_Store" --exclude ".*" --exclude "*.py" --delete
	aws cloudfront create-invalidation --distribution-id EHIS1O5LAO3RR --paths '/*'
}

sync_batch_scripts() {
	# aws s3 sync $FIRST_HOME/pipeline/automation s3://first-io-datalake-production/user/Li/code/automation --exclude "*.csv" --exclude "*.xlsx" --exclude "*.ipynb" --exclude "*.log" --exclude ".*" --exclude "*/.*" --delete
	aws s3 sync $FIRST_HOME/pipeline/automation s3://first-io-datalake-production/user/Li/code/automation --exclude "*" --include "*.py" --exclude "*.ipynb_checkpoints*" --delete
}

upload_first_secrets() {
	scp -i ~/.ssh/ziyueli_first.pem ~/Code/dotfiles/first_secrets ubuntu@$1:~/Code/dotfiles
}

update_secrets() {
	python $DAVINCI_HOME/update_secrets.py
	aws s3 cp ~/.davinci/secrets.yaml s3://first-io-datalake-production/user/Shared/code/.davinci/secrets.yaml
}

# ssh
ec2_li() {
    ssh -o IdentitiesOnly=yes -i ~/.ssh/ziyueli_first.pem ubuntu@$@
}

ec2_li_L() {
    ssh -i ~/.ssh/ziyueli_first.pem -L 8787:localhost:8787 ubuntu@$@
}

ec2_li_bastion() {
    ssh -i ~/.ssh/ziyueli_first.pem ubuntu@$1
}

ec2_first() {
    ssh -i ~/.ssh/firstUbuntu.pem ubuntu@$1
}

spark_li_web() {
	ssh -i ~/.ssh/ziyueli_first.pem -ND 8157 hadoop@$1
}

spark_li() {
	ssh -i ~/.ssh/ziyueli_first.pem hadoop@$1
}

spark_li_bastion() {
	ssh hadoop@$1
}

spark_test() {
	ssh -i ~/.ssh/test-cal.pem hadoop@$1
}

port_forwarding() {
	ssh -i ~/.ssh/ziyueli_first.pem -N -f -L $1:localhost:8888 ubuntu@$2
}

# utilities
add_kernel() {
	conda activate $1
	python -m ipykernel install --user --name $1
}


convertshape() {
	ogr2ogr -f "ESRI Shapefile" $FIRST_HOME/input/shapefiles/$1.shp $FIRST_HOME/input/shapefiles/$1.kml
}


# docker
dockerCsvCleanUp() {
	docker run -it --rm -p 9000:9000 -v /Users/ziyue/OneDrive/Code/Data_analysis/First/data_pipeline:/mnt/notebooks jupyter-first:1.0.0
}

dockerBuildFetchAndRun () {
	cd $FIRST_HOME/docker/list_scoring-test
	docker build -t fetch_and_run .
	docker tag fetch_and_run:latest 485000428307.dkr.ecr.us-west-2.amazonaws.com/fetch_and_run:latest
	docker push 485000428307.dkr.ecr.us-west-2.amazonaws.com/fetch_and_run:latest
}

dockerBuildDask () {
	cd $FIRST_HOME/ECR_images/dask
	docker build -t dask_cluster:$1 .
	docker tag dask_cluster:$1 485000428307.dkr.ecr.us-west-2.amazonaws.com/dask_cluster:$1
	aws ecr get-login-password --region us-west-2 | docker login --username AWS --password-stdin 485000428307.dkr.ecr.us-west-2.amazonaws.com/dask_cluster
	docker push 485000428307.dkr.ecr.us-west-2.amazonaws.com/dask_cluster:$1
}

# AWS
delete_sfn_and_lambdas () {
	cd $FIRST_HOME
	cd state_machines_ds
	python delete.py
}

# Tools
lab () {
	conda activate py39
	code
	jupyter lab
}

#####################################################
# old functions for county models (to be deprecated)
sync_agent_data () {
	date=`date +%Y%m%d`
	runipy ~/OneDrive/Code/Data_analysis/First/cortex/Data_pipeline/Sync_agents_data_and_create_Athena_table-cleaned_up.ipynb ~/OneDrive/Code/Data_analysis/First/output/scheduled_jobs/sync_agent_contacts_and_create_Athena_table-${date}.ipynb
	jupyter nbconvert --to html ~/OneDrive/Code/Data_analysis/First/output/scheduled_jobs/sync_agent_contacts_and_create_Athena_table-${date}.ipynb
}

ipyjob () {
	export FILE_NAME=$1
	runipy ~/IPython_notebook/predictive-model/ipython/New_model-Ziyue_Li/Acxiom_targetModel_POC_Ziyue_Li.ipynb ~/IPython_notebook/output/ipynb_report_html/${FILE_NAME}${BATCH_ID}.ipynb
	# jupyter nbconvert --to html ~/IPython_notebook/output/ipynb_report_html/${FILE_NAME}${BATCH_ID}.ipynb
	# aws s3 cp ~/IPython_notebook/output/ipynb_report_html/${FILE_NAME}${BATCH_ID}.html s3://predictive-model/datafiles/output/New_model_Li/ipynb_report_html/${FILE_NAME}${BATCH_ID}.html
	# rm ~/IPython_notebook/output/ipynb_report_html/${FILE_NAME}${BATCH_ID}.ipynb
}

batchloop () {
	export BATCH_ID=$2
	for f in $1
	do
		ipyjob $f
	done
}

# ipybatchjob still needs to be tested
ipybatchjob () {
	cd ~/IPython_notebook/predictive-model/ipython/New_model-Ziyue_Li/
	python ipybatchjob.py "$1" "$2"
}
