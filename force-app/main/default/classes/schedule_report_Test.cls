@isTest
public class schedule_report_Test{
    private static testmethod void test_schedule(){
        Schedule_Report__c sch = new Schedule_Report__c();
        sch.Start_Date__c = System.now();
        sch.End_Date__c = system.now()+5;
        sch.Email_Addresses__c = 'achsharath@gmail.com , sharath@gmail.com';
        insert sch;
        
        schedule_report SR = new schedule_report();
        SR.create_Task(sch.Start_Date__c , sch.End_Date__c, sch.id );
        
    }
}