@istest
public class AccountProcessorTest{
    public static testmethod void countCon(){
        Account aa = new Account();
        aa.Name = 'Deloitte';
        Insert aa;
        
        Contact cc = new Contact();
        cc.FirstName = 'Sharat';
        cc.LastName = 'Chikkanna';
        cc.Email = 'schikkanna@deloitte.com';
        cc.MobilePhone = '9986081788';
        insert cc;
        
        List<Id> acc = new List<Id>();
        acc.add(aa.Id);
        
        Test.startTest(); 
        AccountProcessor.countContacts(acc);
        Test.stopTest();
    }
}