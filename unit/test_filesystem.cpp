#include <gtest/gtest.h>
#include <plugins/plugin_manager.h>

using namespace iotfs;

TEST(IoTFS_NULL, NULL) {
  EXPECT_EQ(1,1);
}

TEST(IoTFS_Plugin, PluginManager) {
  PluginManager* pm = PluginManager::instance();
  EXPECT_TRUE(pm != nullptr);
}
