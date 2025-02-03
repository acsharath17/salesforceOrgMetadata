public class My_New_Class {
	public static id acc_id;
    
    public static Void create_acc(string a){
        Account acc = new Account();
        acc.name = a;
        acc.Type = 'Prospect123';
        acc.Website = 'www.cloud.com';
        acc.Phone = '23239664';
        insert acc;
        acc_id = acc.id;
       
    }
    
    public static void create_con(String abc,string c_name){
       
        create_acc(abc);
        contact c = new contact();
        c.lastname = c_name;
        c.AccountId = acc_id;
        insert c;
    }
}