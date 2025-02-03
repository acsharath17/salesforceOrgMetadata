trigger Check_New_Map on Account (after update) {
    
    List<Contact> cc = [Select id,lastname,accountid from contact WHERE AccountId in: trigger.newmap.keyset()];
    
    List<Contact> con = new List<contact>();
    for(Contact c : cc){
        Account a = trigger.newmap.get(c.accountID);
        system.debug('This is from IDE');
        c.lastname = a.name;
        con.add(c);
    }
    
    update con;
    
}