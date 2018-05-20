alias hstart="/usr/local/Cellar/hadoop/2.6.0/sbin/start-dfs.sh;/usr/local/Cellar/hadoop/2.6.0/sbin/start-yarn.sh"
alias hstop="/usr/local/Cellar/hadoop/2.6.0/sbin/stop-yarn.sh;/usr/local/Cellar/hadoop/2.6.0/sbin/stop-dfs.sh"
alias zepstart="~/App_build/zeppelin-0.7.1-bin-all/bin/zeppelin-daemon.sh start"
alias zepstop="~/App_build/zeppelin-0.7.1-bin-all/bin/zeppelin-daemon.sh stop"

# data
first_lftp () {
	lftp -p 22 -u $CI_FTP_USERNAME,$CI_FTP_PASSWORD sftp://sfgext.acxiom.com
}

get_premover() {
	python2 $FIRST_HOME/pipeline/premover/premover_download_upload.py $1 $2
}


# sync
sync_spark() {
	aws s3 sync $FIRST_HOME/vesta/src/main/Pyspark_2.0/ s3://predictive-model/code/Li/Spark_national_model/
	aws s3 sync $FIRST_HOME/davinci/ s3://predictive-model/code/Li/davinci/
	cd $FIRST_HOME
	zip -r davinci.zip davinci
	aws s3 cp davinci.zip s3://predictive-model/code/Li/davinci.zip
	# cd ~/OneDrive/Code/Data_analysis/First/spark/src/main/Pyspark_2.0/
	# zip -r lib.zip lib
	# aws s3 cp lib.zip s3://predictive-model/code/Li/custom_modules/lib.zip
	# rm lib.zip
}


sync_brainy_flat_table_to_athena() {
	python2 $FIRST_HOME/pipeline/sync_brainy/Sync_agents_data_and_create_Athena_table.py
}

upload_spark() {
	aws s3 cp $FIRST_HOME/spark/src/main/Pyspark_2.0/ s3://predictive-model/code/Li/Spark_national_model/ --recursive
}


# ssh
ec2_li() {
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

spark_test() {
	ssh -i ~/.ssh/test-cal.pem hadoop@$1
}


# utilities
convertshape() {
	ogr2ogr -f "ESRI Shapefile" $FIRST_HOME/input/shapefiles/$1.shp $FIRST_HOME/input/shapefiles/$1.kml
}


# docker
dockerCsvCleanUp() {
	docker run -it --rm -p 9000:9000 -v /Users/ziyue/OneDrive/Code/Data_analysis/First/data_pipeline:/mnt/notebooks jupyter-first:1.0.0
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
