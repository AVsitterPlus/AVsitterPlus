/******************************************************************
* Requires AVP_prop script from box 2.1-07 or later!
*
* This example uses 90220 to rez a prop while any one of a number of poses are playing.
* Useful if you want the same prop to remain rezzed for several poses.
* May help save prop script memory in cases you are re-using the same prop over and over.
*
* To use:
* 1. Set up a regular prop that rezzes with a pose as usual.
*
* 2. Change the PROP's <trigger_name> in the notecard to be a completely new name.
* The new name should *NOT* match a pose name so the prop will rez *ONLY* by this script.
*      e.g. PROP PicnicProp...
*
* 3. Edit the "prop_trigger" string below to match this name.
*      e.g. string prop_trigger = "PicnicProp";
*
* 4. Edit "poses" list below to include all the POSE or SYNC that you want to rez the prop for.
*
* 5. Edit "SITTER" below to match the sitter # the props are for (or use -1 to ignore sitter #).
*
* If you are rezzing props from two or more of these scripts at same time (some poses are in
* more than one script's "poses" list), PROP lines in AVpos notecard must specify different
* <prop_group> for props rezzed by each script. This is necessary because a prop will derez
* when a new prop is rezzed that has the same <prop_group>.
******************************************************************/

string prop_trigger = "PicnicProp";
list poses = ["Sit1","Sit2","cuddle"];
integer SITTER = 0;

/******************************************************************
* DON'T EDIT BELOW THIS UNLESS YOU KNOW WHAT YOU'RE DOING!
******************************************************************/

integer rezzed;

default{
    link_message(integer sender, integer num, string msg, key id){
        if(sender==llGetLinkNumber()){
            if(num==90045){
                list data = llParseStringKeepNulls(msg,["|"],[]);
                string POSE_NAME = llList2String(data,1);
                integer SITTER_NUMBER = (integer)llList2String(data,0);
                key uuid = "";
                if(SITTER!=-1){
                    uuid=id;
                }
                if(SITTER_NUMBER==SITTER || SITTER==-1){
                    if(llListFindList(poses,[POSE_NAME])!=-1){
                        if(rezzed==FALSE){
                            llMessageLinked(LINK_THIS,90220,prop_trigger,uuid);
                            rezzed=TRUE;
                        }
                    }
                    else{
                        llMessageLinked(LINK_THIS,90220,"remprop_"+prop_trigger,uuid); // clear the prop
                        rezzed=FALSE;
                    }
                }
            }
            else if((num==90065 && (integer)msg==SITTER) || num==90030){ //sitter stands or swaps
                rezzed=FALSE;
            }
        }
    }
}
