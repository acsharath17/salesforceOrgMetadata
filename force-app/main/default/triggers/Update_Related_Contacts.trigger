trigger Update_Related_Contacts on Account (after insert , after Update) {
    
    string acc_id;
    string acc_name;
    
    for(Account aa : trigger.new){
        acc_id = aa.id;
        acc_name = aa.name;
          
        List<Contact> cc = [ Select id,lastname,AccountID from Contact WHERE AccountId =: acc_id ]; 
        
        for(contact c : cc){
            c.Lastname = acc_name;
            system.debug('Hello from IDE');
            update c;    
        }
         
    }
    
    /*List<Contact> cc = [ Select id,lastname,AccountID from Contact WHERE AccountId =: acc_id ];
    
    for(contact c : cc){
        c.Lastname = acc_name;
        update c;    
    }*/
    
}