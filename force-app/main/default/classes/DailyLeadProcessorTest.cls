@isTest
public class DailyLeadProcessorTest{
    public static String CRON_EXP = '0 0 0 15 3 ? 2022';
    
    static testMethod void leadTest(){
        List<Lead> leadInsert = new List<Lead>();
        for(integer i=0 ; i<= 200 ; i++){
            Lead l = new Lead();
            l.FirstName = 'Sharat';
            l.LastName = 'Chikkanna '+i;
            l.Company = 'Deloitte '+i;
            leadInsert.add(l);
        }
        insert leadInsert;
        
        Test.startTest();
            String jobId = System.schedule('ScheduledApexTest',CRON_EXP, new DailyLeadProcessor());
        Test.stopTest();
        
        system.assertEquals(200 , [Select Count() From Lead WHERE LeadSource = 'Dreamforce']);
    }
}