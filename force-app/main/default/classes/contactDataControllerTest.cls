@isTest
public class contactDataControllerTest {
    @isTest static  void newCall() {
        
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();        
        mock.setStatusCode(200);
        mock.setStaticResource('GetContact');
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
        
        //setting up mock response        
        Test.setMock(HttpCalloutMock.class, mock);
        
        // Call method to test mock response      
        HttpResponse result = contactDataController.newCall();
        
        contactDataController cd = new contactDataController();
        cd.response1 = result;
        system.debug('Result:::::::: '+result);
        system.debug('Result:::::::: '+cd.response1);
        cd.contactFetch();
        
        // Validate mock response is not null
        System.assertNotEquals(null,result);
        
        // Validate if callout is successful
        System.assertEquals(200,result.getStatusCode());
        
        // Validate records created              
        List<Object> res = (List<Object>) JSON.deserializeUntyped(result.getBody());        
        System.assertEquals(2, res.size());         
    }   
}