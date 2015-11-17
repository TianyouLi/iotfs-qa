#ifndef __IOTFS_DIRECTORY_MOCK__
#define __IOTFS_DIRECTORY_MOCK__

// gmock header
#include <gmock/gmock.h>

// iot_directory
#include <iotfs/iotfs_directory.h>

namespace iotfs {

class MockIoTFolder : public IOTFolder {
public:
  MOCK_METHOD1(makeChildFolder, IOTFolder&(const std::string& name));
};
  
}
#endif
