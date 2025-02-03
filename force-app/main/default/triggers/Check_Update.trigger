trigger Check_Update on Account (after insert,after update) {
    
    for(Account aa : trigger.new){
        if(trigger.isInsert){
            system.debug('Insert');
        }
        if(trigger.isUpdate){
            system.debug('Update');
        }
    }
    
}