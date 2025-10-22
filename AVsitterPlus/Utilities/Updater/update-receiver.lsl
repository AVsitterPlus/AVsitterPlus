/*
 * update-receiver - Allows remote updating of object contents.
 *
 * This Source Code Form is subject to the terms of the Mozilla Public
 * License, v. 2.0. If a copy of the MPL was not distributed with this
 * file, You can obtain one at http://mozilla.org/MPL/2.0/.
 *
 * Copyright © the AVsitter Contributors (http://avsitter.github.io)
 * Copyright © Truth & Beauty Lab (http://avsitterplus.github.io)
 *
 * Please consider supporting continued development of AVsitterPlus and
 * receive automatic updates and other benefits! All details and user
 * instructions can be found at http://avsitterplus.github.io
 */

/*
 * Simple script used for updating a large number of furniture items at once
 * This script goes in each furniture prim that expects an update from the sender
 * will auto-delete if a non-admin avatar rezzes the furniture
 */

integer pin = -29752;

// Enter the list of allowed avatar UUIDs here.
list admin_avatars = ["3506213c-29c8-4aa1-a38f-e12f6d41b804", "d648fb86-d59b-4d69-8d3c-d00862aec699"];

default
{
    state_entry()
    {
        llSetTimerEvent(0.1);
        if (llGetStartParameter() == -1)
        {
            integer i;
            while (llGetInventoryNumber(INVENTORY_OBJECT))
            {
                string item = llGetInventoryName(INVENTORY_OBJECT, llGetInventoryNumber(INVENTORY_OBJECT) - 1);
                llRegionSayTo(llGetOwner(), 0, "Removing :" + item);
                llRemoveInventory(item);
            }
        }
        llSetRemoteScriptAccessPin(pin);
        llListen(pin, "", "", "");
    }

    timer()
    {
        if ((llGetLinkNumber() == 0 || llGetLinkNumber() == 1) && llGetInventoryType("AVP_object") != INVENTORY_SCRIPT)
        {
            if (llGetAgentSize(llGetLinkKey(llGetNumberOfPrims())) == ZERO_VECTOR)
            {
                llSetText(llGetObjectName(), <1,1,0>, 1);
            }
        }
        llSetTimerEvent(10);
    }

    on_rez(integer start)
    {
        if (start)
        {
            if (~llListFindList(admin_avatars, [(string)llGetOwner()]))
            {
                llRegionSayTo(llGetOwner(), 0, "Removing :" + llGetScriptName());
            }
            llSetRemoteScriptAccessPin(0);
            llRemoveInventory(llGetScriptName());
        }
    }

    listen(integer chan, string name, key id, string msg)
    {
        if (llGetOwnerKey(id) == llGetOwner())
        {
            list data = llParseStringKeepNulls(msg, ["|"], []);
            if (llList2String(data, 0) == "OBJECT_SEARCH")
            {
                list reply;
                integer i;
                for (i = 1; i < llGetListLength(data); i++)
                {
                    if (llGetInventoryType(llList2String(data, i)) != INVENTORY_NONE)
                    {
                        reply += [llList2String(data, i), (string)llGetInventoryKey(llList2String(data, i))];
                    }
                }
                if (llGetListLength(reply) > 0)
                {
                    llRegionSay(pin, "OBJECT_HERE|" + llDumpList2String(reply, "|"));
                }
            }
        }
    }

    changed(integer change)
    {
        if (change & CHANGED_OWNER)
        {
            if (llListFindList(admin_avatars, [(string)llGetOwner()]) == -1)
            {
                llSetRemoteScriptAccessPin(0);
                llRemoveInventory(llGetScriptName());
            }
        }
    }
}
