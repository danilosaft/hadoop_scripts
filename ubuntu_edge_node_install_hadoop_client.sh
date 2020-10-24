#!/bin/bash

printf "Adding Haddop client user group to manage access to the client..."
groupadd hadoop_client_access
adduser hadoop
usermod -a -G hadoop_client_access hadoop

echo "If you would like to add other users to the hadoop_client_access group, please enter a user name now and press ENTER. Leave the user name empty to continue."
while [[ -z "$ADDITIONALSER" ]]
do  
  read -s -p "Enter user name: " ADDITIONALSER
  usermod -a -G hadoop_client_access $ADDITIONALSER
done


#apt install oracle-java8-installer
#as per https://tecadmin.net/setup-hadoop-on-ubuntu/:
echo "Changing to user\"hadoop\"..."
su - hadoop
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 0600 ~/.ssh/authorized_keys
ssh localhost
exit

#Todo automatically find latest version from download folder
cd ~
wget https://downloads.apache.org/hadoop/common/hadoop-3.3.0/hadoop-3.3.0.tar.gz
tar xzf hadoop-3.3.0.tar.gz
mv hadoop-3.3.0 hadoop

echo "export HADOOP_HOME=/home/hadoop/hadoop
export HADOOP_CMD=\$HADOOP_HOME
export HADOOP_INSTALL=\$HADOOP_HOME
export HADOOP_MAPRED_HOME=\$HADOOP_HOME
export HADOOP_COMMON_HOME=\$HADOOP_HOME
export HADOOP_HDFS_HOME=\$HADOOP_HOME
export YARN_HOME=\$HADOOP_HOME
export HADOOP_COMMON_LIB_NATIVE_DIR=\$HADOOP_HOME/lib/native
export PATH=\$PATH:\$HADOOP_HOME/sbin:\$HADOOP_HOME/bin" >> ~/.bashrc

source ~/.bashrc

echo "JAVA HOME:"
echo $JAVA_HOME
echo "Please add this folder to the hadoop-env.sh file now: export JAVA_HOME=[path to your java home - see above]"
read -s -p "Press enter to open editor." USERINPUT
nano $HADOOP_HOME/etc/hadoop/hadoop-env.sh

cd $HADOOP_HOME/etc/hadoop
read -s -p "Enter your namenode address: " NAMENODE
