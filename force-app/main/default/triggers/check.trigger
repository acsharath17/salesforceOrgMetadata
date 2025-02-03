trigger check on House__c (before insert, before update) {
    
    if(trigger.isInsert){
        system.debug('Roll up Insert ----------------');
    }else if(trigger.isUpdate){
        system.debug('Roll up update ----------------');
    }    
        
    
}