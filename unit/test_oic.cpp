// unit test framework
#include <gtest/gtest.h>

// third party dependencies
#include <fusekit/daemon.h>

// target under test
#include <iotfs/iotfs.h>
#include <plugins/plugin_manager.h>

using namespace iotfs;

class OICPluginTest : public ::testing::Test {
public:
  OICPluginTest() : _pm(nullptr) {}
  
protected:
  virtual void SetUp() {
    _pm = PluginManager::instance();
  }

  virtual void TearDown() {
    if (_pm != nullptr) {
      //delete _pm;
    }
  }

  PluginManager* _pm;
};

TEST_F(OICPluginTest, IsNULL) {
  EXPECT_TRUE(nullptr != _pm);
}

TEST_F(OICPluginTest, hasPlugin) {
  EXPECT_TRUE(_pm->size() > 0);
}

TEST_F(OICPluginTest, initialization) {
  for (IoTInfoProvider* provider : *_pm) {
    EXPECT_NO_THROW(provider->initialize(&g_daemon));
  }
}

