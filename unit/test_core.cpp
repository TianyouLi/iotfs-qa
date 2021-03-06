#include <memory>

// unit test framework
#include <gtest/gtest.h>

// third party dependencies
#include <fusekit/daemon.h>

// target under test
#include <iotfs/iotfs.h>
#include <iotfs/utils.h>
#include <plugins/plugin_manager.h>

using namespace iotfs;

TEST(IoTFS_NULL, NULL) {
  EXPECT_EQ(1,1);
}

TEST(IoTFS_Core, g_daemon) {
  struct stat stbuf;
  EXPECT_EQ(0, iotfs::g_daemon.root().stat(stbuf));
}

TEST(IoTFS_Core, IoTFSInitializer) {
  EXPECT_NO_THROW(std::shared_ptr<IoTFSInitializer> p
                  = std::make_shared<IoTFSInitializer>());
}

TEST(IoTFS_Core, IoTFolder) {
  IoTFolder folder;
  std::string folder_name = "test";
  EXPECT_NO_THROW(folder.makeChildFolder(folder_name));
}

TEST(IoTFS_Core, lexicalcast) {
  std::string T = "true";
  std::string F = "false";
  std::string Tx = "truex";
  std::string Fx = "falsex";

  EXPECT_TRUE(boost::lexical_cast<bool>(T));
  EXPECT_FALSE(boost::lexical_cast<bool>(F));
  
  EXPECT_ANY_THROW(boost::lexical_cast<bool>(Tx));
  EXPECT_ANY_THROW(boost::lexical_cast<bool>(Fx));
}

TEST(IoTFS_Plugin, PluginManager) {
  PluginManager* pm = PluginManager::instance();
  EXPECT_TRUE(pm != nullptr);
  delete pm;
}


