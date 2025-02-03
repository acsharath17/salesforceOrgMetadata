public class sharat2 {

    public string Acc_name{get;set;}
    public string con_name{get;set;}
    public string mob {get;set;}
    public string email{get;set;}
    
    public Account create_acc(){
        Account aa = new Account();
        aa.name = Acc_name;
        insert aa;
        return aa;
    }
    
    public pagereference create_acc_con(){
        Account acc = create_acc();
        contact c = new Contact();
        c.lastname = con_name;
        c.phone= mob;
        c.email = email;
        c.AccountId = acc.id;
        insert c;
        return new pagereference('/'+acc.id);
    }
    
}