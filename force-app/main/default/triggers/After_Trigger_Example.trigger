trigger After_Trigger_Example on Account (before insert,after insert) {
    
    if(trigger.isBefore){
        for(Account a : trigger.new){
        
            contact c = new contact();
            c.LastName = a.name +  ' Before Trigger';
            c.AccountId =  a.id;
            insert c;
        }    
    }
    
    if(Trigger.isAfter){
        for(Account a : trigger.new){
        
            contact c = new contact();
            c.LastName = a.name + ' After Trigger';
            c.AccountId =  a.id;
            insert c;
        }     
    }
    
    
}