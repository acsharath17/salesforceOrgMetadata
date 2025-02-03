@istest
public class Updatecontactaccount_Test {
    static testmethod void testbatch(){
        account a = new account();
        a.name = 'BICS';
        insert a;
        contact c = new contact();
        c.lastname = 'Test';
        c.accountid = a.id;
        insert c;
        account acc = new account();
        acc.name = 'test11';
        insert acc;
        contact con = new contact();
        con.lastname = 'Test11';
        con.accountid = acc.id;
        insert con;
        
        test.StartTest();
        updatecontactaccount up1 = new updatecontactaccount();
        string sch = '0 0 23 * * ?';
        system.schedule('Testing',sch,up1);
        
        test.StopTest();
        updatecontactaccount up = new updatecontactaccount();
        database.executebatch(up);
     }
}