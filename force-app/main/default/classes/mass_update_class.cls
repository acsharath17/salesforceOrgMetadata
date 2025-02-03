public class mass_update_class {
    
    public list<Contact> con {get;set;}
    public set<Contact> ss{get;set;}
    public mass_update_class(){
        con = new List<Contact>();
        
        con = [Select id,name,Lastname,email,phone From Contact];
        
        //set<contact>ss1 = [Select id,name,Lastname,email,phone From Contact];
    }
    
    public pagereference update_rec(){
        
        system.debug('AAAAAAAAAAAAAAAAAAAAAAAAA'+con.size());
        
        for(contact c : con){
            list <Contact> cc = [Select id,name From Contact];
            update c;
            //update ss;
        }
        
        //upsert con;
        
        pagereference p = new pagereference ('https://ap2.salesforce.com/003/o');
        
        return p;
        
    }

}