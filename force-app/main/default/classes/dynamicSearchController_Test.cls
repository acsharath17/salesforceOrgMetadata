@isTest
public class dynamicSearchController_Test {
    public static testmethod void m1(){
        Account acc = TestDataFactory.createAccount('Salesforce', 'Prospect', 'Consulting');
        Contact con = TestDataFactory.createContact(acc.Id, 'Sharat', 'Chikkanna', 'chikkannasharath@gmail.com');
        Search_Setting__c ss = TestDataFactory.createSS('Account', 'Id,Name,Type,Industry,MasterRecordId', 'Name,Type,Industry');
        Search_Setting__c ss1 = TestDataFactory.createSS('Contact', 'Id,Name,Email,Account.Name', 'Name,Type,Industry');
        
        dynamicRecordSearchController DS = new dynamicRecordSearchController();
        sObject obj;
        List<string> ll = dynamicRecordSearchController.getselectOptions(obj, 'Name,Type,Industry');
        object obb = dynamicRecordSearchController.Get_Record_For_Table_Input_From_Query('Account', 'Salesforce');
        object obb1 = dynamicRecordSearchController.Get_Record_For_Table_Input_From_Query('Contact', 'Sharat Chikkanna');
        
        List<string> ll1 = Lightning_Data_Table_Class.getselectOptions(obj, 'Name,Type,Industry');
        object obb22 = Lightning_Data_Table_Class.Get_Record_For_Table_Input_From_Query('Account', 'Salesforce');
        object obb12 = Lightning_Data_Table_Class.Get_Record_For_Table_Input_From_Query('Contact', 'Sharat Chikkanna');
        
        dynamicRecordSearchController.EachRecord DS1 = new dynamicRecordSearchController.EachRecord();
        
        User u = new User(
         ProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard Platform User'].Id,
         LastName = 'last',
         Email = 'puser000@amamama.com',
         Username = 'puser000@amamama.com' + System.currentTimeMillis(),
         CompanyName = 'TEST',
         Title = 'title',
         Alias = 'alias',
         TimeZoneSidKey = 'America/Los_Angeles',
         EmailEncodingKey = 'UTF-8',
         LanguageLocaleKey = 'en_US',
         LocaleSidKey = 'en_US'         
        );
        
        system.runAs(u){
            object obb2 = dynamicRecordSearchController.Get_Record_For_Table_Input_From_Query('Account', 'Salesforce');
            object obb3 = Lightning_Data_Table_Class.Get_Record_For_Table_Input_From_Query('Account', 'Salesforce');
        }
    }
}