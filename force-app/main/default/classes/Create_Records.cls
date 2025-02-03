public class Create_Records {
	
    public static Account Acc(string ab,string ph){
        Account a = new Account();
        a.name = ab;
        a.Phone = ph;
        insert a;
        
        return a;
    }
    
    public static void con(){
        account ac = acc('Test Non Void1','9986081788');
		contact c = new contact();
        c.LastName = 'Contact from class';
        c.AccountId = ac.id;
        c.Phone = ac.phone;
        insert c;
    }
    
}