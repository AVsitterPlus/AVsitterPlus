/******************************************************************
* This example will send a greeting message to each new sitter
******************************************************************/

default{
    link_message(integer sender, integer num, string msg, key id){
        if(num==90060){
            llSay(0,"Welcome, "+llKey2Name(id));
        }
        else if(num==90065){
            llSay(0,"Goodbye, "+llKey2Name(id));
        }
    }
}
