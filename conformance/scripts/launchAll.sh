#!/bin/bash

###############################################################
#
# Top level launch script to execute all conformance test
#
###############################################################

CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd ${BLD_DIR}

# Enumerate all sub directories and call build.sh correspondingly
for sub in ../*/; do
  if [ -e ${sub}/launch.sh ]
	then
		echo "*********** launch...${sub} **************"
		bash ${sub}/launch.sh
	fi
done

cd ${CUR_DIR}
