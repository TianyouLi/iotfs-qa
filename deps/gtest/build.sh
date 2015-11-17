#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}

# download googletest from github
git clone https://github.com/TianyouLi/googletest.git

# create build dir
mkdir -p ${BLD_DIR}/build_gtest
mkdir -p ${BLD_DIR}/build_gmock

cd ${BLD_DIR}/build_gtest
cmake -Dgtest_build_samples=ON -DCMAKE_CXX_COMPILER_ARG1=-std=c++0x ${BLD_DIR}/googletest/googletest
make
cd ${CUR_DIR}

cd ${BLD_DIR}/build_gmock
cmake -Dgtest_build_samples=ON -DCMAKE_CXX_COMPILER_ARG1=-std=c++0x ${BLD_DIR}/googletest/googlemock
make
cd ${CUR_DIR}
