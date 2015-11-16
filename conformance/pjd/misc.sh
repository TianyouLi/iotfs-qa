#!/bin/sh

# Get initial directory
CUR_DIR=`pwd`
BLD_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# Get PJD FS Test Suite directory
PJD_DIR=${BLD_DIR}/../../deps/pjdfstest/pjdfstest


# Get PJD FS Test environment
. ${PJD_DIR}/tests/misc.sh


