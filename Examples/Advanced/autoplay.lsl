/******************************************************************
* Automatically plays COUPLES_POSE when 2 avatars sit.
* Optionally plays SINGLES_POSE when one avatar stands.
* Requires scripts from box 2.1-11.01 or later.
******************************************************************/

string COUPLES_POSE = "Couples1";
string SINGLES_POSE = ""; //can leave empty

/******************************************************************
 * DON'T EDIT BELOW THIS UNLESS YOU KNOW WHAT YOU'RE DOING!
******************************************************************/

integer IS_SYNC;

default{
   changed(integer change){
        if(change & CHANGED_LINK){
            llSleep(1);
            integer avatar_count = llGetNumberOfPrims() - llGetObjectPrimCount(llGetKey());
            if(avatar_count>1){ // more than one avatar sitting
                if(!IS_SYNC){ // initial avatar had not selected a SYNC pose
                    llMessageLinked(LINK_SET,90000,COUPLES_POSE,""); // play couples pose
                }
            }
            else if(SINGLES_POSE){
                llMessageLinked(LINK_SET,90000,SINGLES_POSE,""); // play singles pose
            }
        }
    }
    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
            // Extract the data into a list
            list data = llParseStringKeepNulls(msg,["|"],[]);
            // TRUE if the pose is a SYNC pose
            IS_SYNC = (integer)llList2String(data,6);
        }
    }
}
