#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}
make clean
rm -rf CMakeCache.txt CMakeFiles CTestTestfile.cmake Makefile Testing cmake_install.cmake gtest iotfs
cd ${CUR_DIR}
