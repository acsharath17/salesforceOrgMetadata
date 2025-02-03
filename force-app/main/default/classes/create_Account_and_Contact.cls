public class create_Account_and_Contact {
    public string a_name{get;set;}
    public string c_name{get;set;}
    
    
    
    public Account create_acc(){
        Account a = new Account();
        a.name = a_name;
        insert a;
        return a;
    }
    
    public pagereference create_Con(){
        account aa = create_acc();
        contact c = new contact();
        c.lastname = c_name;
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@@@@'+c_name);
        c.accountId = aa.id;
        insert c;
        return new pagereference('/'+aa.id);
    }
    
    public pagereference insert_records(){
        
        Account a = new Account();
        a.name = a_name;
        insert a;
        
        contact c = new contact();
        c.lastname = c_name;
        c.accountId = a.id;
        insert c;
        return new pagereference('/'+a.id);
        
    }
    
    public pagereference go_next(){
        return page.assignment_evening_01;
    }
    
}