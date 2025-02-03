@isTest
public class TestRestrictContactByName{
    static testmethod void testName(){
        contact c = new contact();
        c.Lastname = 'INVALIDNAME';
        Database.SaveResult result = Database.Insert(c, false);
        System.assert(!result.isSuccess());
        System.assert(result.getErrors().size() > 0);
        System.assertEquals('The Last Name "INVALIDNAME" is not allowed for DML',result.getErrors()[0].getMessage());
        
    }
}