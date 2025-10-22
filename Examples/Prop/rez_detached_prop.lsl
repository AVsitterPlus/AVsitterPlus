/******************************************************************
 * Simple example of re-rezzing all attachment props as soon as the avatar detaches them
******************************************************************/

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90500){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            string EVENT = llList2String(data,0);
            string PROP_NAME = llList2String(data,2);
            if(EVENT == "DETACHED"){
                llMessageLinked(LINK_THIS,90220,PROP_NAME,"");
            }
        }
     }
}
