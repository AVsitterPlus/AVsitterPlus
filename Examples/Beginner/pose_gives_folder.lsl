/******************************************************************
* This example will give items in a folder when a specific pose plays
******************************************************************/
string posename = "Propose";
list items = ["Flowers","Ring"];
string foldername = "Proposal Gear";

// SITTER: Specify the SITTER # or leave as -1 for all SITTER's
integer SITTER = -1;

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            integer SITTER_NUMBER = (integer)llList2String(data,0);
            if(SITTER_NUMBER==SITTER || SITTER==-1){
                if(llList2String(data,1)==posename){
                    llSleep(2);
                    llGiveInventoryList(id,foldername,items);
                }
            }
        }
    }
}
