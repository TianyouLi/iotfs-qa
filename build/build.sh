#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}
cmake ../unit
make
cd ${CUR_DIR}

# test
cd ${BLD_DIR}
make test
cd ${CUR_DIR}


# generate coverage report for unit test
cd ${BLD_DIR}
lcov --capture --directory .. --output-file unit_coverage.info 2>coverage.log
lcov --remove unit_coverage.info 'boost/*' 'c++/*' 'include/gtest/*' '*/iotfs-qa/*' '*/iotfs/deps/*' 'src' -o unit_coverage_filtered.info 1>>coverage.log
genhtml unit_coverage_filtered.info --output-directory ../reports/coverage/unit
cd ${CUR_DIR}

