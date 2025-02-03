@isTest
Public class Send_Daily_Report_test{
    private static testmethod void test_mail(){
        
        List<User> u = [Select id,name from User];
        //List <Report> reportList = [SELECT Id,DeveloperName FROM Report Where FolderName = 'Daily_Report'];
        
        Schedule_Report__c sch = new Schedule_Report__c();
        sch.Start_Date__c = System.now();
        sch.End_Date__c = system.now()+5;
        sch.Email_Addresses__c = 'achsharath@gmail.com , sharath@gmail.com';
        insert sch;
        List<id> ids = new List<id>();
        ids.add(sch.id);
        
        Reports_Sceduled__c rep_sch = new Reports_Sceduled__c();
        rep_sch.Report_Folder__c = 'Folder Name';
        rep_sch.Report_Id__c = '00OO0000000gQWO';
        rep_sch.Report_Name__c = 'Report Name';
        rep_sch.Scheduler__c = sch.id;
        insert rep_sch;
        
        Reports_Sceduled__c rep_sch1 = new Reports_Sceduled__c();
        rep_sch1.Report_Folder__c = 'Folder Name';
        rep_sch1.Report_Id__c = '00OO0000000gQWO';
        rep_sch1.Report_Name__c = 'Report Name';
        rep_sch1.Scheduler__c = sch.id;
        insert rep_sch1;
        
        Users_Receving__c UR = new Users_Receving__c();
        UR.User__c = u[0].id;
        UR.Scheduler__c = sch.id;
        insert UR;
        
        Send_Daily_Report.schedule_report(ids);
        Send_Daily_Report.test_method();
    }
}