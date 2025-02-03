public class New_App_Class {

    public New_App_Class(ApexPages.StandardController controller) {

    }

    
    public string a_name{get;set;}
    public string a_web{get;set;}
    public string a_ph{get;set;}
    
    /*public void insert_acc(){
        Account acc = new Account();
        system.debug(a_name +' vvvv ' +a_web+' vvvv '+a_ph);
        acc.name = a_name;
        acc.Website = a_web;
        acc.Phone = a_ph;
        insert acc;
        
        system.debug(a_name +' bbbbbbb ' +a_web+' bbbbbbb '+a_ph);
    }  */ 
    
    public pagereference insert_acc(){
        Account acc = new Account();
        system.debug(a_name +' vvvv ' +a_web+' vvvv '+a_ph);
        acc.name = a_name;
        acc.Website = a_web;
        acc.Phone = a_ph;
        insert acc;
        
        system.debug(a_name +' bbbbbbb ' +a_web+' bbbbbbb '+a_ph);
        
        return new Pagereference('/'+acc.id);
    }
    
    public Pagereference go_google(){
        Pagereference pg = new Pagereference('https://www.google.com');
        return pg;
    } 
}