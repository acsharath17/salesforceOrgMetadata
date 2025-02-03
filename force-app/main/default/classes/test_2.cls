public class test_2 {
    
    public string account_name{get;set;}
    public string phone{get;set;}
    public string fax{get;set;}
    
    public test_2(ApexPages.StandardController controller) {

    }
    
    public void custom_save(){
    
        Account a = new Account();
        a.name = account_name;
        a.Phone = phone;
        a.fax = fax;
        insert a;
    }

}