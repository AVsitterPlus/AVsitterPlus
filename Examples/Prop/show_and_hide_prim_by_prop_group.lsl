/******************************************************************
 * Hide/Show furniture prim when certain <prop_group> is rezzed or derezzed/detached.
 * Place in the prim to hide/show.
 * Uses AVP_prop's 90500 link message.
******************************************************************/

string PROP_GROUP = "GROUP1"; // <prop_group> to hide/show for

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90500){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            string command = llList2String(data,0);
            string group = llList2String(data,4);

            if(group==PROP_GROUP){
                if(command=="REZ"){ // prop rezzed
                    llSetLinkAlpha(LINK_THIS,0,ALL_SIDES); //hide prim
                }
                else if(command=="DEREZ" || command=="DETACHED"){ // prop derezzed or detached
                    llSetLinkAlpha(LINK_THIS,1,ALL_SIDES); //show prim
                }
            }
        }
    }
}
