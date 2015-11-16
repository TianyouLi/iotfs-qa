#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}
if [ -f Makefile ]; then
		make clean
fi
rm -rf CMakeCache.txt CMakeFiles CTestTestfile.cmake Makefile Testing cmake_install.cmake gtest iotfs
rm -rf *.info
rm -rf *.log
rm -rf ../reports 
cd ${CUR_DIR}
