@isTest
public class ParkLocatorTest{
    
    public static testmethod void parkTest(){
        Test.setMock(WebServiceMock.class, new ParkServiceMock());
        string[] abc = ParkLocator.Country('India');
        
        string[] abc1 = ParkLocator.Country('China');
    }
}