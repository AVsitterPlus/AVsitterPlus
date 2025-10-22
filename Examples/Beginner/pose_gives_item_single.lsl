/******************************************************************
* This example will give a single item to the avatar when a specific pose plays
******************************************************************/
string posename = "Eat Cake";
string itemname = "Cake";

// SITTER: Specify the SITTER # or leave as -1 for all SITTER's
integer SITTER = 0;

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            integer SITTER_NUMBER = (integer)llList2String(data,0);
            string POSE_NAME = llList2String(data,1);
            if(SITTER_NUMBER==SITTER || SITTER==-1){
                if(POSE_NAME==posename){
                    llGiveInventory(id,itemname);
                }
            }
        }
    }
}
