export FIRST_HOME="$CODE_HOME/Data_analysis/First"
export PYTHONPATH=$PYTHONPATH:$FIRST_HOME
export PATH=$PATH:$PYTHONPATH
export PATH=$PATH:~/App_build

export HADOOP_OPTS="-Djava.library.path=$HADOOP_INSTALL/lib/native"
export PYTHONIOENCODING="utf-8"

# export JAVA_HOME="$(/usr/libexec/java_home)"
export SPARK_HOME=~/App_build/spark-2.3.0-bin-hadoop2.7
export PYSPARK_DRIVER_PYTHON="jupyter"
export PYSPARK_DRIVER_PYTHON_OPTS="notebook"
export PYSPARK_PYTHON="/Applications/anaconda3/envs/py27/bin/python"