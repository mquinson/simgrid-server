// This autogenerated skeleton file illustrates how to build a server.
// You should copy it to another filename to avoid overwriting it.

#include "rsg/actor.hpp"
#include "rsg/mailbox.hpp"
#include "rsg/comm.hpp"
#include "rsg/host.hpp"
#include "rsg/engine.hpp"

#include <xbt.h>
#include <simgrid/s4u.hpp>

#include <iostream>

XBT_LOG_NEW_CATEGORY(RSG_THRIFT_CLIENT, "Remote SimGrid");
XBT_LOG_NEW_DEFAULT_SUBCATEGORY(RSG_THRIFT_REMOTE_CLIENT, RSG_THRIFT_CLIENT , "RSG server (Remote SimGrid)");

using boost::shared_ptr;
using namespace ::simgrid;

int main() {
    rsg::HostPtr host1 = rsg::Host::by_name("host1");
    
    XBT_INFO("hostname ->  %s with speed %f", host1->getName().c_str(), host1->speed());
    XBT_INFO("hostname ->  %s with speed %f", rsg::Host::current()->getName().c_str(),rsg::Host::current()->speed());
    // XBT_INFO("actor name -> %s", self.getName());/
    
    rsg::this_actor::execute(8095000000 * 1.999999);
    rsg::this_actor::sleep(1);
    rsg::this_actor::quit();
//     rsg::closeConnection();
    
    // rsg::this_actor::sleep(1);
    return 0;
}
