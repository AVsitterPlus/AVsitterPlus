/******************************************************************
* This example will set custom position/rotation of prims with certain poses.
* Only for use in a child prim. Please read comments for information and settings.
******************************************************************/

// DEBUG: if set TRUE then touching the prim will read the prims local position/rotation to chat.
// DEBUG mode allows you to get the data for the DEFAULT and CUSTOM lists below.
// DEBUG should be set to TRUE while you're building and then set to FALSE when you're finished.
integer DEBUG = TRUE;

// SITTER: the SITTER# the script responds to.
integer SITTER = 0;

// Default Position and Rotation of the prim
list DEFAULT = [<0.00000, 0.00000, 1.36389>,<-179.96040, 0.00000, 0.00000>];

// CUSTOM is a list of poses and the custom Position and Rotation for each pose.
// The CUSTOM list is in the format of <pose name>,<prim_position>,<prim_rotation>
// If a pose is not in this list then the position will revert to the DEFAULT.
list CUSTOM = [
    "Pose1",<0.00000, 0.00000, 2.34100>,<-90.00001, 0.00000, 0.00000>,
    "Pose2",<-0.03568, 0.00000, 1.50464>,<-90.00000, 0.00000, 0.00000>,
    "Pose3",<0.14161, 0.88953, 1.97498>,<-151.00680, -4.00000, 0.00000>,
    "Pose4",<0.04294, -0.00032, 2.58356>,<0.00000, 89.98022, -179.98020>
];

// list of poses to ignore SITTER setting and move anyway (e.g. for SYNC poses)
list SYNCS = [];

// DESCRIPTION: if given, then script reacts only to link messages from prim with matching description
string DESCRIPTION = "";

/******************************************************************
 * DON'T EDIT BELOW THIS UNLESS YOU KNOW WHAT YOU'RE DOING!
******************************************************************/

key AVATAR;

default_position(){
    AVATAR=NULL_KEY;
    if(llGetLinkNumber()>1){// only move the prim if the script is in a child prim.
        llSetPrimitiveParams([PRIM_POS_LOCAL,llList2Vector(DEFAULT,0),PRIM_ROT_LOCAL,llEuler2Rot(llList2Vector(DEFAULT,1)*DEG_TO_RAD)]);
    }
}

default{
    state_entry(){
        //default_position();
    }
    link_message(integer sender, integer num, string msg, key id){
        if(DESCRIPTION=="" || llList2String(llGetObjectDetails(llGetLinkKey(sender),[OBJECT_DESC]),0)==DESCRIPTION){//check the sender prim's description
            if(llGetLinkNumber()>1){// only move the prim if the script is in a child prim.
                if (num==90045){ // a pose is played!
                    list data = llParseStringKeepNulls(msg,["|"],[]);
                    integer SITTER_NUMBER = (integer)llList2String(data,0);
                    string POSE_NAME = llList2String(data,1);
                    if(SITTER_NUMBER==SITTER || llListFindList(SYNCS,[POSE_NAME])!=-1){ // correct SITTER or in SYNC list
                        integer index = llListFindList(CUSTOM,[POSE_NAME]);
                        if(index!=-1){ // move prim to a custom position
                            AVATAR = id;
                            llSetPrimitiveParams([PRIM_POS_LOCAL,llList2Vector(CUSTOM,index+1),PRIM_ROT_LOCAL,llEuler2Rot(llList2Vector(CUSTOM,index+2)*DEG_TO_RAD)]);
                        }
                        else{ // move prim to default position
                            default_position();
                        }
                        // llMessageLinked(LINK_THIS,90000,POSE_NAME,(key)((string)SITTER_NUMBER)); // uncomment this line if you are moving the prim that contains the sit script!
                    }
                    else if(id==AVATAR){ // our avatar has swapped sitters.
                        default_position();
                    }
                }
                else if(num==90065 && (integer)msg==SITTER){ // avatar stands up!
                    default_position();
                }
            }
        }
    }
    touch_start(integer touched){
        if(llDetectedKey(0)==llGetOwner() && DEBUG==TRUE){
            if(llGetLinkNumber()>1){
                llOwnerSay((string)llList2Vector(llGetPrimitiveParams([PRIM_POS_LOCAL]),0)+","+(string)(llRot2Euler(llList2Rot(llGetPrimitiveParams([PRIM_ROT_LOCAL]),0))*RAD_TO_DEG));
            }
            else{
                llOwnerSay("This script should only be used in a child prim.");
            }
        }
    }
    changed(integer change){
        if(change & CHANGED_LINK){
            if(llGetAgentSize(llGetLinkKey(llGetNumberOfPrims()))==ZERO_VECTOR){// if no avatars are sitting.
                default_position();
            }
        }
    }
}
