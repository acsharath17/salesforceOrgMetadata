public class display_records {

    public list<Selectoption> so {get;set;}
    public string selected_obj {get;set;}
    public list<Sobject> all_rec {get;set;}
    
    public display_records(){    
        so = new List<SelectOption>();
        so.add(new selectoption ('--None--','Select Option'));
        so.add(new selectoption ('Account','Account'));
        so.add(new selectoption ('contact','contact'));
        so.add(new selectoption ('Opportunity','Opportunity'));
        so.add(new selectoption ('Session__c' , 'Session'));
    }
    
    public List<Account> aa {get;set;}
    public List<Contact> cc {get;set;}
    public List<Opportunity> opp {get;set;}
    
    public boolean accnt = false;
    public boolean cont = false;
    
    public void set_boolean(){
        if(selected_obj == 'Account'){
            accnt = true;
        }
        
        if(selected_obj == 'Contact'){
            cont = true;
        }
    
    }
    
    public List<Account> getacc(){
     aa = new List <Account>();  
     aa = [Select name From Account];
     return aa;
    }
    
    public List<Contact> getcon(){
        cc = new List<Contact>();
        cc = [Select Lastname from contact];
        return cc;
    }

}