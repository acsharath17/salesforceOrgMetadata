public class example_2 {
    public integer a = 10;
    public string ab = 'Sharat';
    
    public list<integer> a1 = new list<integer>();
    
    public example_2(){
        system.debug('this is my constructor');
    }
    
    public Account save_acc(string acc_name, string typ, string web){
        Account a = new Account();
        a.Name = acc_name;
        a.Type = typ;
        a.Website = web;
        insert a;
        return a;
    }
    
    public void save_acc_con(){
        account ab = save_acc('cloud','Prospect','www.fb.com');
        contact c = new contact();
        c.lastname = 'test contact insert';
        c.AccountId = ab.id;
        insert c;
    }
    
}