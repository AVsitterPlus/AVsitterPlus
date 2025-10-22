/******************************************************************
* This example will show/hide a prim when a button is pressed in the menu.
* Place this script into the prim you want to make invisible.
*
* You will need a line in the AVP_Positions notecard to create the BUTTON:
* BUTTON Blanket|0
******************************************************************/

string button_name = "Blanket";
integer visible=TRUE;

default {
    state_entry(){
        llSetAlpha(1,ALL_SIDES);//visible
    }
    link_message(integer sender, integer num, string msg, key id){
        if(msg==button_name){
            if(visible){
                llSetAlpha(0,ALL_SIDES);//invisible
            }
            else{
                llSetAlpha(1,ALL_SIDES);//visible
            }
            llMessageLinked(LINK_SET,90005,"",id); // give back the menu
            visible=!visible;
        }
    }
}
