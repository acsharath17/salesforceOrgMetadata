trigger Account_Update on Account (before insert , before update , after insert , after update) {
    
    if(trigger.isInsert && trigger.isBefore ){
        system.debug('Im inside is Insert');    
    }
    
    if(trigger.isUpdate){
        system.debug('Im Inside is Update');         
    }
    
    if(trigger.isbefore){
        
    }
    
    if(trigger.isAfter ){
        system.debug('After Trigger');
        if(trigger.isInsert){
            system.debug('After Insert Trigger');
        }    
    }
    
    if(trigger.isDelete){
        
    }
    
}