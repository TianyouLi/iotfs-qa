// unit test framework
#include <gtest/gtest.h>

// third party dependencies
#include <fusekit/daemon.h>

// target under test
#include <iotfs/iotfs.h>
#include <plugins/plugin_manager.h>


using namespace iotfs;

TEST(IoTFS_NULL, NULL) {
  EXPECT_EQ(1,1);
}

TEST(IoTFS_Core, g_daemon) {
  struct stat stbuf;
  EXPECT_EQ(0, iotfs::g_daemon.root().stat(stbuf));
}

TEST(IoTFS_Core, CDtor) {
  EXPECT_NO_THROW(iotfs::CDtor cdtor);
}

TEST(IoTFS_Plugin, PluginManager) {
  PluginManager* pm = PluginManager::instance();
  EXPECT_TRUE(pm != nullptr);
}
