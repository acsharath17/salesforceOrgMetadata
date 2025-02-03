trigger AccountAddressTrigger on Account (before insert,before update) {
    if(trigger.isBefore){
        if(trigger.isInsert || trigger.isUpdate)
            accountTriggerHandler.postalCodeCopy(trigger.new);
    }
}