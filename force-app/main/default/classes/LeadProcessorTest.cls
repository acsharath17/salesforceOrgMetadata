@isTest
public class LeadProcessorTest{
    public static testmethod void leadTest(){
        List<Lead> leds = new List<Lead>();
        for(integer i=0; i < 200 ; i++){
            Lead l = new Lead();
            l.LastName = 'Chikkanna '+i;
            l.Company = 'Deloitte '+i;
            l.LeadSource = 'Web';
            leds.add(l);
        }
        insert leds;
        
        Test.startTest();
            LeadProcessor LP = new LeadProcessor();
            Database.executeBatch(LP);
        Test.stopTest();
        
        system.assertEquals(200, [Select Count() from Lead WHERE LeadSource = 'Dreamforce']);
    }
}