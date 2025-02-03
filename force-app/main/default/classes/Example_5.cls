public class Example_5 {
	
    public integer a ;
    
    public Example_5(){
    	a = 10;
        system.debug('Initialization inside constructor' + a);
    }
	
    public Account create_Account(string a1 , string b, string c){
        Account a = new Account();
        a.name = a1;
        a.Phone = b;
        a.fax = c;
        insert a;
        return a;
    }
    
    public void create_contact(string a,string b , string cc){
        Account aa = create_Account(a,b,cc);
        List<Contact> con = new List<Contact>();
        contact c = new contact();
        c.lastname = 'Sharat Chikkanna';
        c.AccountId = aa.id;
        con.add(c);
        //insert c;
        contact c1 = new contact();
        c1.lastname = 'Nandeesh';
        c1.AccountId = aa.id;
        con.add(c1);
        insert con;
    }
    

}