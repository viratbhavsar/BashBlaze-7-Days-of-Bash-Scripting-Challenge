#!/bin/bash

#Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

#Check OS
OS=$(grep '^NAME=' /etc/os-release | cut -d'=' -f2 |tr -d '"')

if [[ $OS != "Ubuntu" ]]
  then
   echo -e "${RED}[ERROR]This script is only for Linux (Ubuntu) OS${NC}"
   exit 1;
fi

#Check user is root or not
function checkuser(){
  if [[ $UID != 0 ]]
    then
      echo -e "${RED}[ERROR]User is not a root user !! Try using root user.${NC}"
      exit 1
  fi
}

checkuser

#Take user input to install package
read -p "Enter the package name to install: " package

#sleep 10 &
if [[ -z ${package} ]]
  then
   echo "Please enter package to install"
   exit 1;
fi
sleep 5 && apt-get install -y ${package,,} > /dev/null 2>&1 &

#Fetch PID
last_pid=$!

#Progress bar
while ps | grep -i "${last_pid}" > /dev/null
do
  for i in '-' '\' '|' '/'
    do
      echo -ne "\b${i}"
        sleep 0.15
  done
 echo -ne "\b"
done

if ! wait ${last_pid}
  then
    echo -e "${RED}${package,,} is not installed ! Might need some dependencies or incorrect package name, Kindly Check manually${NC}"
  else
    echo -e "${GREEN}${package,,} installed successfully${NC}"
fi
