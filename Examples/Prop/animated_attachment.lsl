/******************************************************************
* This optional script can be added to attachment props.
* Triggers an animation placed inside the attachment prop at regular intervals when attachment is worn (e.g. for sipping/drinking).
* Use with caution! The animation can easily interfere with other animations already playing.
* Animation should be uploaded with animation priority >= other animations that are playing.
******************************************************************/

float TIMER = 10.0; // how often to play the animation

/******************************************************************
* DON'T EDIT BELOW THIS UNLESS YOU KNOW WHAT YOU'RE DOING!
******************************************************************/

check_attached(){
    if(llGetAttached()){
        llRequestPermissions(llGetOwner(),PERMISSION_TRIGGER_ANIMATION);
    }
    else{
        integer perms = llGetPermissions();
        if(perms & PERMISSION_TRIGGER_ANIMATION){
            llStopAnimation(llGetInventoryName(INVENTORY_ANIMATION,0));
        }
        llSetTimerEvent(0);
    }
}

default{
    attach(key id){
        check_attached();
    }

    timer(){
        if(llGetAttached()){
            integer perms = llGetPermissions();
            if(perms & PERMISSION_TRIGGER_ANIMATION){
                llStartAnimation(llGetInventoryName(INVENTORY_ANIMATION,0));
            }
        }
    }

    run_time_permissions(integer perm){
        if(perm & PERMISSION_TRIGGER_ANIMATION){
            llSetTimerEvent(TIMER);
        }
    }

    on_rez(integer x){
        check_attached();
    }
}
