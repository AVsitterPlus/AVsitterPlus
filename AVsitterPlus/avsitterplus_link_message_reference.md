# AVsitterPlus&trade; Developer Link Message Reference

The following [link messages](http://wiki.secondlife.com/wiki/Link_message) are used in AVsitterPlus.

This list is not intended for the casual user. Public API info for general users can be found [here](https://avsitterplus.github.io/avsitterplus.html).

This page may provide additional info if the purpose of a link message is not initially clear.

**AVsitterPlus uses link messages in the range 90000-90500.**

### 90000
Play an animation defined in AVpos notecard.

    lMessageLinked(LINK_THIS,90000,<POSE_NAME>,<CUSTOM>);
    
    Where for <CUSTOM>:
        ""      = try to play the pose for all SITTERS.
        UUID    = try to play the pose to avatar by UUID.
        integer = apply the pose to a sitter e.g. SITTER 0.

### 90001
Play an overlay animation (AVP_adjuster, AVP_faces).

    llMessageLinked(LINK_THIS,90001,<ANIMATION_FILE>,<AVATAR_UUID>);

### 90002
Stop an additional animation (AVP_adjuster, AVP_faces).

    llMessageLinked(LINK_THIS,90002,<ANIMATION_FILE>,<AVATAR_UUID>);

### 90003
Same as 90000 but ignored by AVP_sequence script to prevent from stopping sequences when AVP_sequence itself plays poses.

### 90004
Same as 90005 but returns to top level of the menu (used by AVP_root-RLV when pressing [MENU]).

### 90005
Give the menu. Optionally set controller avatar and/or submenu.

Note: AVP_menu only accepts the first form below; it does not accept TOMENU or CONTROLLER_UUID.

    llMessageLinked(LINK_SET,90005,"",<AVATAR_UUID>);
    llMessageLinked(LINK_SET,90005,<TOMENU>,[<CONTROLLER_UUID>|<AVATAR_UUID>]);
    
    TOMENU=-1 ensures when sitters first sit they will get AVP_select menu if the AVP_select script is present

### 90006
Register touch or sit to AVP_root-security script from AVP_sitA after permissions granted.

    llMessageLinked(LINK_SET,90006,"",<AVATAR_UUID>);
    llMessageLinked(LINK_SET,90006,<FUNCTION>,<AVATAR_UUID>); // for AVselect!
    
    FUNCTION=-1 ensures when sitters first sit they will get AVP_select menu if the AVP_select script is present

### 90007
AVP_root-security passes touch to AVP_root-control.

    llMessageLinked(LINK_SET,90007,"",<CONTROLLER_UUID>);

### 90008
Same as 90000 but if the pose is a SYNC pose, it's played by all sitters that have it, regardless of target (i.e. works pretty much like choosing the pose in the menu)

### 90009
Bring up AVP_select menu, sent by AVP_sitB.

    llMessageLinked(LINK_SET,90009,"",<AVATAR_UUID>);

### 90010
Same as 90000 but ignores ETYPE.

### 90011
AVP_adjuster tells AVP_sitA scripts to set the llSetLinkCamera().

### 90012
AVP_root-security passes touch or sit to AVP_root-RLV.

    llMessageLinked(LINK_THIS, 90012,<ACTIVE_PRIM>,<CONTROLLER_UUID>);

### 90014
AVP_root-RLV notifies user scripts of the controlling avatar & captive avatars.

    llMessageLinked(LINK_SET,90014,llDumpList2String([CONTROLLER_UUID,llDumpList2String(CAPTIVES,",")],"|"),"");    

### 90020
Tells a script to [DUMP] settings.

    llMessageLinked(LINK_THIS,90020,<SITTER>,<SCRIPT_NAME>);

### 90021
Tells AVP_adjuster to ask the next script to [DUMP] settings.

    llMessageLinked(LINK_THIS,90021,<SITTER#>,<SCRIPT_NAME>);

### 90022
Tell AVP_adjuster a read out settings [DUMP] line.

    llMessageLinked(LINK_THIS,90022,<TEXT>,<SITTER#>);

### 90030
Tell AVP_sit scripts and AVP_adjuster to [SWAP] between two sitters.

    llMessageLinked(LINK_THIS,90030,<SITTER#>,<SITTER#>);

### 90033
AVP_control tells listeners in AVP_sit & AVP_root-security scripts to reset after capture to prevent captive using an open menu, and when someone "takes control of menu".

    llMessageLinked(LINK_SET,90033,"","");

### 90045
AVP_sitA gives info about the pose just played. Received by many scripts.

    link_message(integer sender, integer num, string msg, key id){
        if(num==90045){
           
            // The avatar UUID
            key AVATAR_UUID = id;
           
            // Extract the data into a list
            list data = llParseStringKeepNulls(msg,["|"],[]);
           
            // The SITTER# the pose is playing for
            integer SITTER_NUMBER = (integer)llList2String(data,0);
           
            // The name of the pose
            string POSE_NAME = llList2String(data,1);
           
            // The animation file
            string ANIM_FILE = llList2String(data,2);
           
            // The SET#
            integer SET = (integer)llList2String(data,3);
           
            // A list of UUIDs of all sitting avatars separated by the ( @ ) character
            list ALL_SITTERS = llParseStringKeepNulls(llList2String(data,4),["@"],[]);
           
            // The name the SYNC pose the avatar is leaving
            string OLD_SYNC_NAME = llList2String(data,5);
           
            // TRUE if the pose is a SYNC pose
            integer IS_SYNC = (integer)llList2String(data,6);
           
        }
    }


### 90050
A pose is selected from the menu

    default{
        link_message(integer sender, integer num, string msg, key id){
            if(num==90050){
                key AVATAR_UUID = id;
                list data = llParseStringKeepNulls(msg,["|"],[]);
                string SITTER_NUMBER = llList2String(data,0);
                string POSE_NAME = llList2String(data,1);
                string SET = llList2String(data,2);
            }
        }
    }

### 90051
Same as 90050 but when a TOMENU is selected from the menu.

### 90055
AVP_sitB sends anim info to other scripts.

    llMessageLinked(LINK_THIS,90055,<SITTER#>,<POSE_NAME,ANIMATION_FILE,POSITION,ROTATION,BROADCAST>);
    
    Where <BROADCAST> is if we want to send a 90045 in response.

### 90056
Same as 90055 but sent from AVP_sitA when an avatar sits (so helper sticks know where to go). 

### 90057
Sent by AVP_adjuster when helper moves, so AVP_sitA can update position.

    llMessageLinked(LINK_THIS,90057,<SITTER#>,<POSITION,ROTATION>);

### 90060
Welcome new sitter!

    llMessageLinked(LINK_SET,90060,"",<AVATAR_UUID>);

### 90065
Goodbye Sitter! Received by several scripts.

    llMessageLinked(LINK_SET,90065,<SITTER#>,<AVATAR_UUID>);

### 90070
Update list of SITTERS in various scripts after permissions granted. Received by several scripts.

    llMessageLinked(LINK_THIS,90070,<SITTER#>,<AVATAR_UUID>);

### 90075
Used by oldschool HELPER 1 method - ask to animate.

### 90076
Used by oldschool HELPER 1 method - stop animate.

### 90100
Menu choice from AVP_sitA. Also sent by AVP_sitB for [RLV] button and by AVP_root-RLV-extra for [BACK]

### 90101
Menu choice. Sent and received by several scripts.

    llMessageLinked(LINK_SET,90101,<SITTER#,MSG,CONTROLLER_UUID>,<AVATAR_UUID>);

### 90150
AVP_sitA for SITTER 0 requests all AVP_sitA scripts re-place their sittarget.

### 90171
AVP_adjuster add PROP line to AVP_prop.

### 90172
AVP_adjuster add ANIM line to AVP_faces.

### 90173
AVP_menu add PROP line to AVP_prop.

### 90174
AVP_adjuster add CAMERA line to AVP_camera.

### 90200
Default integer for a BUTTON line in the AVpos notecard. Used to rez props. If UUID is specified, menu is returned to that avatar. A second UUID can be specified to rez the prop for one avatar, but return the menu to another.

### 90220
Same as 90200 but no menu is returned. 

### 90201
AVP_sitA asks for info about what plugins are available.

### 90202
Reply that script exists in root: AVP_root-security (and AVP_root-RLV).

### 90203 (not used)
Reply that script exists in root: AVP_texture.

### 90204 (not used)
Reply that script exists in root: AVP_color.

### 90205
Toggle sound in the AVP_sequence script.

### 90206
AVP_root-RLV sends information to AVP_control.

### 90207
RLV sends hovertext details.

### 90208
AVP_root-RLV tells AVP_root-RLV-extra to open "Un/Dress" menu.

### 90209
AVP_root-RLV tells AVP_root-RLV-extra to open "Restrict" menu.

### 90210
Default integer for a SEQUENCE line in the AVpos notecard. Used by AVP_sequence.

### 90211
AVP_control sends [CAPTURE] message to AVP_root-RLV.

    llMessageLinked(LINK_THIS,90211,"",<CONTROLLER_UUID>);

### 90230
Control AVP_camera with BUTTON or link message.

    llMessageLinked(LINK_THIS,90230,<CAMERA_NAME>,<AVATAR_UUID>);

### 90298
AVP_djuster tells AVP_sitA to show SitTargets (/5 targets).

### 90299
AVP_sitA resets AVP_sitB

    llMessageLinked(LINK_THIS,90299,<SITTER#>,"");

### 90300
AVP_sitA, AVP_adjuster updates AVP_sitB.

### 90301
More AVP_sitA, AVP_adjuster updates to AVP_sitB.

### 90302
AVP_sitA sends initial notecard settings data to AVP_sitB.

### 90401
AVP_favs command to add pose to favourites

    llMessageLinked(LINK_THIS,90401,<POSE_NAME>,<AVATAR_UUID>);

### 90402
AVP_favs command to remove pose from favourites

    llMessageLinked(LINK_THIS,90402,<POSE_NAME>,<AVATAR_UUID>);

### 90403
AVP_favs command to show favourites list

    llMessageLinked(LINK_THIS,90403,"",<AVATAR_UUID>);

### 90500
AVP_prop reports on prop events (ATTACHED,DETACHED,REZ,DEREZ).

    default{
        link_message(integer sender, integer num, string msg, key id){
            if(num==90500){
                list data = llParseStringKeepNulls(msg,["|"],[]);
                key AVATAR_UUID = id;
                string EVENT = llList2String(data,0);
                string SITTER_NUMBER = llList2String(data,1);
                string PROP_NAME = llList2String(data,2);
                string PROP_OBJECT = llList2String(data,3);
                string PROP_GROUP = llList2String(data,4);
                string PROP_UUID = llList2String(data,5);
                llOwnerSay(llDumpList2String([EVENT, SITTER_NUMBER, PROP_NAME, PROP_OBJECT, PROP_GROUP, PROP_UUID, AVATAR_UUID],","));
            }
        }
    }



