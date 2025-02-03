public class actionFunctionController {
    public Account acc{get;set;}
    public Boolean showPhone{get;set;}
 
    public actionFunctionController(){
        acc = new Account();
        showPhone = false;
    }
 
    public PageReference priorityChanged(){
        if(acc.CustomerPriority__c == 'High'){
            showPhone = true;
        }
        else{
            showPhone = false;
        }
        return null;
    }
    
    public void insert_contact(){
        contact cc = new contact();
        cc.firstname = 'Sharat';
        cc.lastname = 'Chikkanna';
        insert cc;
    }
}