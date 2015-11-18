#!/bin/bash

CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
SCRIPT=`basename ${BASH_SOURCE[0]}`
CMN_DIR=${BLD_DIR}/../common
IOTFS_SETUP=${CMN_DIR}/setup.sh
IOTFS_CLEANUP=${CMN_DIR}/cleanup.sh
TESTS=${BLD_DIR}/suites


function LOG {
	echo "[${SCRIPT}] $@"
}

cd ${BLD_DIR}

# get IoTFS mount point
IOTFS_MOUNT_POINT=`${IOTFS_SETUP}`
if [ $? -ne 0 ];
then
	LOG "Can not find mount point, caused by [${IOTFS_MOUNT_POINT}]."
	exit 1
fi

IOTFS_MOUNT_POINT=`echo ${IOTFS_MOUNT_POINT} | cut -d" " -f1`
LOG "Found IoTFS mount point at ${IOTFS_MOUNT_POINT}"

# go to IoTFS filesystem
cd ${IOTFS_MOUNT_POINT}

# run test using prove
for sub in ${BLD_DIR}/suites/*/; do
	LOG "Start Test Suite ======== ${sub}"
	SUITE_NAME=`basename ${sub}`
	for case in ${sub}*.t; do
		CASE_NAME=`basename ${case}`
		# see if the test case in blacklist
		grep "${SUITE_NAME}/${CASE_NAME}" ${BLD_DIR}/blacklist.txt >/dev/null
		if [ $? -ne 0 ];
		then
			LOG ".. Launch Test `basename ${case}`"
			prove ${case}
		else
			LOG ".. Ignore Test `basename ${case}`"
		fi
	done
	LOG "End   Test Suite ======== ${sub}"
done

cd ${BLD_DIR}

# unmount iotfs
eval ${IOTFS_CLEANUP}

# get back to original directory
cd ${CUR_DIR}
