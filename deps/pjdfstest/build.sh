#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}

# download googletest from github
git clone https://github.com/TianyouLi/pjdfstest.git

cd ${BLD_DIR}/pjdfstest
make 
cd ${CUR_DIR}


if [ -x ${BLD_DIR}/pjdfstest/pjdfstest ]
then
	echo "Copy pjdfstest executable to ${BLD_DIR}/../../conformance/pjd/"
	cp -f ${BLD_DIR}/pjdfstest/pjdfstest ${BLD_DIR}/../../conformance/pjd/
	cp -f ${BLD_DIR}/pjdfstest/tests/conf ${BLD_DIR}/../../conformance/pjd/suites
	cp -f ${BLD_DIR}/pjdfstest/tests/misc.sh ${BLD_DIR}/../../conformance/pjd/suites
fi
