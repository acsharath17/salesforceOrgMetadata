public class Sharat_example_2 {
    
    public Account create_Account_hello(String a, string b, string c){
        Account acc = new Account();
        acc.name = a;
        acc.Type = b;
        acc.Website = c;
        Insert acc;         
        return acc;
    }
    
    public void create_con(String a, string b, string c){
		Account aa =  create_Account_hello(a,b,c);       
        contact cc = new contact();
        cc.lastname = 'Sharat';
        cc.AccountId = aa.id;
        cc.Birthdate = system.today();
        insert cc;
    }
}