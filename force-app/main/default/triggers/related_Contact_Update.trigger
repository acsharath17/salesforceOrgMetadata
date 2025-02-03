trigger related_Contact_Update on Account (after Insert , after Update) {
    
    map<id,Account> acc_map = new map<id,Account>();
    
    string ab;
    integer ac;
    id ac_id;
    
    for(Account aa : trigger.new){
        
        ab = aa.id;
        //ac = aa.id;
        ac_id = aa.id;
        
        //string old_value = trigger.oldmap.get(aa.id).name;
        string new_value = aa.name;
        
        //system.debug('@@@@@@@@@@@@@@@ old_value '+old_value);
        system.debug('@@@@@@@@@@@@@@@ new_value '+new_value);
        
        //if(trigger.oldmap.get(aa.id).name != aa.name){
            acc_map.put(aa.id,aa);
        //}
        
        
    }
    
    system.debug('DDDDDDDDDDDDDDDDDDD '+acc_map.size());
    
    if(acc_map.size() > 0)
    {
        List<Contact> cc = [Select id,lastname,AccountId from Contact WHERE AccountID in: acc_map.keyset()];
        
        List<Contact> con = new List<contact>();
        
        for(Contact c : cc){
            
            Account aa = acc_map.get(c.AccountId);
            
            c.lastname = aa.name;
            
            con.add(c);
        }
        
        update con;
    }
}