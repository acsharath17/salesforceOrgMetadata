public class Account_E2 {
    
    public string acc_name{get;set;}
    public string acc_phone{get;set;}
    public string acc_website{get;set;}
    public string acc_fax{get;set;}
    
    public pagereference save_Account(){
        Account acc = new Account ();
        acc.name = acc_name;
        acc.phone = acc_phone;
        acc.website = acc_website;
        acc.fax = acc_fax;
        insert acc;
        
        return page.Account_E1;
    }
    
}