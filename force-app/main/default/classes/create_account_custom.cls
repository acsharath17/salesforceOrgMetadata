public class create_account_custom {
    public string acc_name{get;set;}
    public string acc_phone{get;set;}
    public string acc_type{get;set;}
    public string acc_website{get;set;}
    
    public pagereference save_account(){
        Account aa = new Account();
        aa.name = acc_name;
        aa.Phone = acc_phone;
        aa.type = acc_type;
        aa.website = acc_website;
        insert aa;
        
        return new pagereference('/'+aa.id);
    }
    
}