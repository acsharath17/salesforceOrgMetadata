Trigger LeadMassTransfernotallowed on Lead (after update){
    
    if(trigger.isUpdate){
        Id userProfileId = userinfo.getProfileId(); 
        String userProfileName = [SELECT ID, Name from Profile Where Id = :userProfileId].Name;
        
        for(Lead leadInsert: Trigger.new){
            if(userProfileName <> 'System Administrator' && leadInsert.OwnerId != trigger.oldMap.get(leadInsert.Id).OwnerId){
                //system.debug('my Oldvalue');                      
                    leadInsert.adderror('You do not have the permission to mass transfer Lead Ownership, contact SalesOp');           
            }
        }
    }
    
}