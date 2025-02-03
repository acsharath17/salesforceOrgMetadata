@isTest
public class TestVerifyDate{
    static testmethod void veri1(){
        
        date d1 = VerifyDate.CheckDates(date.today().addDays(1),date.today().addDays(10));
        //system.assertEquals(date.today().addDays(10),d1);
        
        date d2 = VerifyDate.CheckDates(date.today().addDays(1),date.today().addDays(40));
        Date startDate = System.Date.today().toStartOfMonth(); 
        Date endDate = startDate.addMonths(1).addDays(-1);
        //system.assertEquals(endDate,d2);
    }
}