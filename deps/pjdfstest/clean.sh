#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )


cd ${BLD_DIR}/pjdfstest
make clean
cd ..; rm -rf ${BLD_DIR}/pjdfstest
cd ${CUR_DIR}
