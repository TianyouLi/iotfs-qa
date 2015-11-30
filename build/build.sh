#!/bin/bash
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

cd ${BLD_DIR}
cmake ../unit
make
cd ${CUR_DIR}

# test
cd ${BLD_DIR}
IOTFS_BIN_DIR=${BLD_DIR}/../../iotfs/bin CTEST_OUTPUT_ON_FAILURE=TRUE make test
cd ${CUR_DIR}


# generate coverage report for unit test
cd ${BLD_DIR}
lcov --capture --directory .. --output-file unit_coverage.info > coverage.log 2>&1
lcov --remove unit_coverage.info 'boost/*' 'c++/*' 'include/gtest/*' '*/iotfs-qa/*' '*/iotfs/deps/*' '/usr/include/*' 'src' -o unit_coverage_filtered.info 1>>coverage.log 2>&1
genhtml unit_coverage_filtered.info --output-directory ../reports/coverage/unit 2>/dev/null
cd ${CUR_DIR}

