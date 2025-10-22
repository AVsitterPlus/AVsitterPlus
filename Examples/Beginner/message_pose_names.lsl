/******************************************************************
* This example will send a message to the avatar each time a pose plays
******************************************************************/

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            string POSE_NAME = llList2String(data,1);
            llRegionSayTo(id,0,"Playing pose "+POSE_NAME);
        }
    }
}
