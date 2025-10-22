/******************************************************************
* This example will give different items to inventory when poses play
******************************************************************/

// SITTER: Specify the SITTER # or leave as -1 for all SITTER's
integer SITTER = -1;

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            list data = llParseStringKeepNulls(msg,["|"],[]);
            integer SITTER_NUMBER = (integer)llList2String(data,0);
            string POSE_NAME = llList2String(data,1);
            if(SITTER_NUMBER==SITTER || SITTER==-1){

                // When 'Eat Cake' pose is played, give 'Cake'.
                if(POSE_NAME=="Eat Cake"){
                    llGiveInventory(id,"Cake");
                }

                // When 'Drink Coffee' pose is played, give 'Coffee'.
                else if(POSE_NAME=="Drink Coffee"){
                    llGiveInventory(id,"Coffee");
                }

                // When 'Dine' pose is played, give 'Knife' and 'Fork'.
                else if(POSE_NAME=="Dine"){
                    llGiveInventory(id,"Knife");
                    llGiveInventory(id,"Fork");
                }

            }
        }
    }
}
