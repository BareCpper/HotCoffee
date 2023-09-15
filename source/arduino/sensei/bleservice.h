#pragma once

#include "iservice.hpp"

class BleService : sub0::SubscribeAll<Setup, Update>
{
    void receive( const Setup& ) override
    { setup(); }

    void receive( const Update& ) override
    { update(); }

    bool setup();
    bool update();
};