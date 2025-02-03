public class Example_23 {

    public Static Account new_Account(string na , string ph , string fa){
        Account acc = new Account();
        acc.name = na;
        acc.Phone = ph;
        acc.Fax = fa;        
        insert acc;
        return acc;
    }
    
    public static void new_contact(string na , string ph , string fa , string con_name){
        
        Account a = new_Account(na,ph,fa);
        
        contact cc = new contact();
        cc.lastname = con_name;
        cc.Email = 'Support@clouexpertsindia.com';
        cc.MobilePhone = '9986081788';
        cc.AccountId = a.id;
        insert cc;
    }
}