# IoTFS: Filesystem for IoT Devices Abstraction and Remote Control

## Introduction
The IoTFS is to provide a filesystem that allows upper level applicaitons to use ordinary file API to manage and control IoT devices which conform with standards include OIC, AllJoyn and others. Thus application level code would not need to couple with particular standards and its implementations, and get rid of build, link and runtime dependencies. Existing tools include find/grep, sed/awk, and vmstat etc remains your friends, and you can even expose IoTFS remotely to other machine by using NFS or SAMBA or SSHFS etc. Beyond above benefits, IoTFS also aim to provide additional layer of security shield for IoT devices, as application level code will not aware of underlying IoT standard implementation details and we can apply filesystem ACL to those directories/files which mapped to IoT devices. 

The current implementation includes a framework built on top of [FUSE](http://fuse.sourceforge.net/)/[fusekit](https://code.google.com/p/fusekit/), a plugin system built on top of [C++ Micro Services](https://github.com/CppMicroServices/CppMicroServices) that implements OSGi service model, and an implemented plugin built on top of IoT standard named [OIC](http://openinterconnect.org/)/[IoTivity](https://github.com/iotivity/iotivity).

The whole project include majorly three part:

* iotfs-core      : This repository
* iotfs-adpaters  : The adapter code that convert one standard to another, for example ONVIF to OIC.
* iotfs-qa        : The QA framework includes unit test and conformance test currently implemented. 

## How to Start

### Environment
The IoTFS-QA was built and tested under Ubuntu 14.04 amd64 system.

### Build
1. Please make sure you have git clone iotfs-core project and successfully build it. 

2. Execute ${IOTFSQA}/deps/buildall.sh
   ```
   cd ${IOTFSQA}
   ./deps/buildall.sh
   ```

3. Execute ${IOTFSQA}/build/build.sh, this will build all unit test cases and execute them.
   ```
   cd ${IOTFSQA}
   ./build/build.sh
   ```

4. Execute ${IOTFSQA}/conformance/scripts/launchAll.sh. It will launch the conformance test cases.
   ```
   cd ${IOTFSQA}
   ./conformance/scripts/launchAll.sh
   ```

## Contributors
   | Name       | Email                     | Github id    |
   |------------|---------------------------|--------------|
   | Tianyou Li | <tianyou.li@gmail.com>    | TianyouLi    |
   |            |                           |              |


