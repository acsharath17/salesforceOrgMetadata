public class Sunday_Class {

    public Sunday_Class(sharat2 controller) {

    }


    public Sunday_Class(ApexPages.StandardController controller) {

    }

        
    public Account create_Account(string acc_name){
       Account acc = new Account();
        acc.name = acc_name;
        acc.Phone = '9986081788';
        acc.AnnualRevenue = 1200;
        insert acc;
        return acc;
    }
    
    public void create_contact(string acc_name,string con_name){
        
        Account a = create_Account(acc_name);
        Contact cc = new Contact();
        cc.lastname = Con_name;
        cc.Email = 'xyzabc@gmail.com';
        cc.AccountId = a.id;
        insert cc;
    }
}