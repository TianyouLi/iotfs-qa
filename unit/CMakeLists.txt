CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(iotfs_unit)

SET ( GCC_COMPILE_FLAGS
	"-DIOTINFOPROVIDER_EXPORTS -D_FILE_OFFSET_BITS=64 -DFUSE_USE_VERSION=27 -DBOOST_LOG_DYN_LINK -DGTEST_USE_OWN_TR1_TUPLE=0 -fprofile-arcs -ftest-coverage -Wall -std=c++0x -g")
SET ( GCC_LINK_FLAGS   "-Wl,-rpath,$(IOTIVITY_LIB_PATH) -fprofile-arcs -ftest-coverage -g")

SET ( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COMPILE_FLAGS}" )
SET ( CMAKE_C_FLAGS    "${CMAKE_CXX_FLAGS} ${GCC_COMPILE_FLAGS}")
SET ( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_LINK_FLAGS}" )

SET ( CMAKE_RUNTIME_OUTPUT_DIRECTORY ${iotfs_unit_SOURCE_DIR}/../bin )

# Set iotfs directory
ADD_SUBDIRECTORY (
	${CMAKE_SOURCE_DIR}/../../iotfs/build
	${iotfs_unit_BINARY_DIR}/iotfs
	EXCLUDE_FROM_ALL
	)
SET (CppMicroServices_DIR ${iotfs_SOURCE_DIR}/../deps/cppus/build)
MESSAGE (STATUS "iotfs project directory:         " ${iotfs_SOURCE_DIR} )

# Generate scripts to launch end-to-end test
CONFIGURE_FILE (${CMAKE_SOURCE_DIR}/../build/setup.sh.in
	${CMAKE_SOURCE_DIR}/../build/setup.sh @ONLY)

FILE (COPY ${CMAKE_SOURCE_DIR}/../build/setup.sh
	DESTINATION ${CMAKE_SOURCE_DIR}/../conformance/common
	FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ
	GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
FILE (REMOVE ${CMAKE_SOURCE_DIR}/../build/setup.sh)

CONFIGURE_FILE (${CMAKE_SOURCE_DIR}/../build/cleanup.sh.in
	${CMAKE_SOURCE_DIR}/../build/cleanup.sh @ONLY)

FILE (COPY ${CMAKE_SOURCE_DIR}/../build/cleanup.sh
	DESTINATION ${CMAKE_SOURCE_DIR}/../conformance/common
	FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ
	GROUP_EXECUTE WORLD_READ WORLD_EXECUTE)
FILE (REMOVE ${CMAKE_SOURCE_DIR}/../build/cleanup.sh)


# This adds another subdirectory, which has 'project(gtest)'.
ADD_SUBDIRECTORY (
	${CMAKE_SOURCE_DIR}/../deps/gtest/googletest/googletest
	${iotfs_unit_BINARY_DIR}/gtest)
MESSAGE (STATUS "gtest project directory:         " ${gtest_SOURCE_DIR} )

# find package
FIND_PACKAGE (CppMicroServices NO_MODULE REQUIRED)
FIND_PACKAGE (Boost)

# set include directory
INCLUDE_DIRECTORIES (
	${iotfs_SOURCE_DIR}/../inc
	${iotfs_SOURCE_DIR}/../deps/fusekit/fusekit/include
	${CppMicroServices_INCLUDE_DIRS}
	${Boost_INCLUDE_DIRS}
	/usr/include/fuse
	)

FILE ( GLOB iotfs_SRC "${iotfs_SOURCE_DIR}/../src/*.cpp" )

# remove the iotfs main
LIST (REMOVE_ITEM iotfs_SRC "${iotfs_SOURCE_DIR}/../src/iotfs_main.cpp")

ENABLE_TESTING ()

# Include the gtest library. gtest_SOURCE_DIR is available due to
# 'project(gtest)' above.
INCLUDE_DIRECTORIES (${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

##############
# Unit Tests
##############
ADD_EXECUTABLE (iotfs_core_test ${iotfs_SRC} test_core.cpp)

# Standard linking to gtest stuff.
TARGET_LINK_LIBRARIES (iotfs_core_test gtest gtest_main)

# Target to link iotfs dependent libraries
TARGET_LINK_LIBRARIES (iotfs_core_test
	${CppMicroServices_LIBRARIES}
	boost_system
	boost_filesystem
	boost_log
	gcov
	pthread
	fuse
	rt
	dl
	m
	)


# This is so you can do 'make test' to see all your tests run, instead of
# manually running the executable runUnitTests to see those specific tests.
ADD_TEST (NAME iotfs_core COMMAND iotfs_core_test)
