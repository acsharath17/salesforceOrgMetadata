/**
* @author        Nancy Gupta / Apurva Agarwal 
* @date          16/06/2018
* @description   Test Class for covering the classes related to Recon Accelerator
* @name          DEL_RECON_AcceleratorRequest_Test 
*/

@isTest
public class DEL_RECON_AcceleratorRequest_Test{
    @isTest(seeAllData=true)
    static void Recon_Accelerator_Method1(){
        
        Test.startTest();
        DEL_RECON_Accelerator__c reconAccrec = new DEL_RECON_Accelerator__c();
        reconAccrec.Column_Number__c = 2;
        insert reconAccrec;
        
        PageReference pageRef = Page.DEL_RECON_AcceleratorRequest;
        Test.setCurrentPage(pageRef);
        ApexPages.currentPage().getParameters().put('id', reconAccrec.id);
        
        DEL_RECON_AcceleratorRequest reconAcc = new DEL_RECON_AcceleratorRequest();
        reconAcc.csvFileBody = Blob.valueOf('');
        reconAcc.csvFileName = 'test.csv';
        reconAcc.importCSVFile();
        
        
        reconAcc.csvFileBody = Blob.valueOf('Grouping,FOCUS Salesforce/Extract Query\r\nFoundational Data,select count(id) from user');
        reconAcc.csvFileName = 'test2.csv';
        reconAcc.importCSVFile();
        
        Test.stopTest();
        
    }
    
}