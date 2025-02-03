@isTest
public class AddPrimaryContactTest{
    
    static testmethod void createConTest(){
        List<Account> acnt = new List<Account>();
        for(integer i = 0; i<= 100 ; i++){
            Account acc = new Account();
            acc.name = 'Deloitte '+ i;
            acc.BillingCountry = 'USA';
            if(i <= 50){
                acc.BillingState = 'NY';
            }else{
                acc.BillingState = 'CA';
            }
            acnt.add(acc);
        }
        insert acnt;
        
        contact con = new contact();
        con.lastName = 'Chikkanna';
        con.FirstName = 'Sharat';
        con.AccountId = acnt[0].id;
        con.Email = 'schikkanna@deloitte.com';
        con.MobilePhone = '9986081788';
        insert con;
        
        
        AddPrimaryContact APC = new AddPrimaryContact(con,'CA');
        
        Test.startTest();        
        System.enqueueJob(APC);
        Test.stopTest();
        
        system.assertEquals(50,[Select Count() from Contact WHERE Account.BillingState = 'CA']);
    }
}