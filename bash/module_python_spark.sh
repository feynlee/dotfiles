export FIRST_HOME="$CODE_HOME/Data_analysis/First"
export DAVINCI_HOME="$CODE_HOME/Data_analysis/First/davinci/"
export VESTA_HOME="$CODE_HOME/Data_analysis/First/vesta/"
export DATA_HOME="$CODE_HOME/Data_analysis/First/data/"
export PYTHONPATH=$PYTHONPATH:$DAVINCI_HOME
export PATH=$PATH:$PYTHONPATH
export PATH=$PATH:~/App_build

export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
export PYTHONIOENCODING="utf-8"

export JAVA_HOME="$(/usr/libexec/java_home)"
# export JAVA_HOME="/Library/Java/Home"
export SPARK_HOME=/Applications/App_build/spark-2.4.0-bin-hadoop2.7
export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
export PYSPARK_PYTHON="/Applications/Anaconda3/envs/py3/bin/python"