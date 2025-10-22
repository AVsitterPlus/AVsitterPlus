/******************************************************************
* This example will give an object to an avatar who presses a BUTTON in the menu
* You will need a line in the AVpos notecard to create the BUTTON:
* e.g. BUTTON Coffee|0
******************************************************************/

string button = "Coffee";
string itemname = "Coffee Cup";

default{
    link_message(integer sender, integer num, string msg, key id){
        if(msg==button){
            llGiveInventory(id,itemname);
        }
    }
}
