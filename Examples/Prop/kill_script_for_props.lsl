/******************************************************************
* Optional script can help protect prop objects, preventing them from being rezzed normally.
* Deletes/detaches a prop when it is rezzed normally, unless owned by creator of this script.
* The prop will still function normally when rezzed by furniture.

* Normal props (and contents) must be COPY-OK and NO-MOD for NEXT OWNER.
* Attachment props (and contents) must be COPY-TRANSFER and NO-MOD for NEXT OWNER.
* This script must be COPY-TRANS and NO-MOD for NEXT OWNER.
* With permissions correct, this script can't be removed from the prop by end-user.

* Provided as an example only, without any guarantee.
******************************************************************/

string message = "This prop should only be rezzed by the furniture it came with!";

/******************************************************************
* DON'T EDIT BELOW THIS UNLESS YOU KNOW WHAT YOU'RE DOING!
******************************************************************/

default{
    on_rez(integer param){
        if(param==0){
            if(llGetOwner()!=llGetInventoryCreator(llGetScriptName())){
                llRegionSayTo(llGetOwner(),0,message);
                if(llGetAttached()){
                    llRequestPermissions(llGetOwner(),PERMISSION_ATTACH);
                }
                else{
                    llDie();
                }
            }
        }
    }
    run_time_permissions(integer perm){
        if(perm & PERMISSION_ATTACH){
            llDetachFromAvatar();
        }
    }
}
