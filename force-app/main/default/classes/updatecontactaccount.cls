global class updatecontactaccount implements database.batchable<sobject>,schedulable{
    global database.querylocator start(Database.Batchablecontext BC)
    {
        string query = 'select id,name,accountnumber,(select id,lastname,accountid from contacts) from account where name = \'BICS\'';
        return database.getquerylocator(query);
    }
     global void execute(Database.Batchablecontext BC, List<account> Scope){
        list<contact> listcon = new list<contact>();
        map<string,contact> oldmap = new map<string,contact>();
        map<string,contact> newmap = new map<string,contact>();
        account acc = [select id,name,(select id, lastname from contacts) from account where name=: 'BICS'];
            for(contact a : scope[0].contacts){
                oldmap.put(a.lastname,a);
            }
            for(contact c : acc.contacts){
                newmap.put(c.lastname,c);
            }
            for(contact c : oldmap.values()){
                if(!newmap.containskey(c.lastname))
            {
            c.accountid = acc.id;
                listcon.add(c);                                        
            }
            }
            system.debug('contact:'+listcon);
            update listcon;
    }
    global void finish(Database.Batchablecontext BC){
    }
 global void execute(schedulablecontext sc){
    updatecontactaccount up = new updatecontactaccount();
    database.executebatch(up);
    }
}