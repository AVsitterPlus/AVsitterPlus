/******************************************************************
* This example will send a chat message when a specific pose plays
******************************************************************/

string posename = "Eat Cake";
string message = "Eating Cake! Yum Yum!";

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            string POSE_NAME = llList2String(data,1);
            if(POSE_NAME==posename){
                llSay(0,message);
            }
        }
    }
}
