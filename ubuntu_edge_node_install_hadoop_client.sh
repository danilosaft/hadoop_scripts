#!/bin/bash

printf "Adding Haddop client user group to manage access to the client..."
groupadd hadoop_client_access
adduser hadoop_client
usermod -a -G hadoop_client_access hadoop

echo "If you would like to add other users to the hadoop_client_access group, please enter a user name now and press ENTER. Leave the user name empty to continue."
while [[ -z "$ADDITIONALSER" ]]
do  
  read -s -p "Enter user name: " ADDITIONALSER
  usermod -a -G hadoop_client_access $ADDITIONALSER
done


#apt install oracle-java8-installer

echo "Changing to user\"hadoop_client\"..."
su - hadoop_client


