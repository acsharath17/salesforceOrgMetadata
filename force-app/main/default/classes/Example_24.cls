public class Example_24 {

    public string Account_name{get;set;}
    
    public Example_24(ApexPages.StandardController controller) {

    }

    
    public integer a;
    
    public void create_contact(){
        
        Account aa = new Account();
        aa.name = Account_name;
        insert aa;
      
        contact c = new contact();
      c.lastname = Account_name + ' - Contact';
      c.Email = 'ach@gmail.com';
        c.AccountId = aa.id;
      insert c;
      
        opportunity opp = new opportunity();
        opp.Name = Account_name + ' - opp';
        opp.CloseDate = system.today();
        opp.StageName = 'Prospecting';
        opp.AccountId = aa.id;
        insert opp;
        
    }
}