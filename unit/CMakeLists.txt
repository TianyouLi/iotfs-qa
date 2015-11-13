CMAKE_MINIMUM_REQUIRED(VERSION 2.8)

PROJECT(iotfs_unit)

SET ( GCC_COMPILE_FLAGS "-DIOTINFOPROVIDER_EXPORTS -D_FILE_OFFSET_BITS=64 -DFUSE_USE_VERSION=27 -DBOOST_LOG_DYN_LINK -Wall -std=c++0x -O3")
SET ( GCC_LINK_FLAGS    "-Wl,-rpath,$(IOTIVITY_LIB_PATH) -O3")

SET( CMAKE_CXX_FLAGS  "${CMAKE_CXX_FLAGS} ${GCC_COMPILE_FLAGS}" )
SET( CMAKE_EXE_LINKER_FLAGS  "${CMAKE_EXE_LINKER_FLAGS} ${GCC_LINK_FLAGS}" )

# Set iotfs directory
ADD_SUBDIRECTORY(${CMAKE_SOURCE_DIR}/../../iotfs/build ${iotfs_unit_BINARY_DIR}/iotfs)
MESSAGE( STATUS "iotfs project directory:         " ${iotfs_SOURCE_DIR} )
INCLUDE_DIRECTORIES(${iotfs_SOURCE_DIR}/../inc)

# This adds another subdirectory, which has 'project(gtest)'.
ADD_SUBDIRECTORY(${CMAKE_SOURCE_DIR}/../deps/gtest/googletest/googletest ${iotfs_unit_BINARY_DIR}/gtest)
MESSAGE( STATUS "gtest project directory:         " ${gtest_SOURCE_DIR} )

# Find dependent packages
SET(CppMicroServices_DIR ${iotfs_SOURCE_DIR}/../deps/cppus/build)
FIND_PACKAGE(CppMicroServices NO_MODULE REQUIRED)
FIND_PACKAGE(Boost)

ENABLE_TESTING()

# Include the gtest library. gtest_SOURCE_DIR is available due to
# 'project(gtest)' above.
INCLUDE_DIRECTORIES(${gtest_SOURCE_DIR}/include ${gtest_SOURCE_DIR})

##############
# Unit Tests
##############
ADD_EXECUTABLE(runUnitTests test_filesystem.cpp)

# Standard linking to gtest stuff.
TARGET_LINK_LIBRARIES(runUnitTests gtest gtest_main)

# Target to link iotfs dependent libraries
TARGET_LINK_LIBRARIES(runUnitTests
	${CppMicroServices_LIBRARIES}
	boost_system
	boost_filesystem
	boost_log
	pthread
	fuse
	rt
	dl
	m
	)


# This is so you can do 'make test' to see all your tests run, instead of
# manually running the executable runUnitTests to see those specific tests.
ADD_TEST(NAME that-test-I-made COMMAND runUnitTests)

# You can also omit NAME and COMMAND. The second argument could be some other
# test executable.
ADD_TEST(that-other-test-I-made runUnitTests)
