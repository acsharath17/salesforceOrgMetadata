@Istest(SeeAllData=true)
public class AccountManagerTest {
    

    
    @IsTest
    public static void testaccountmanager() {
        RestRequest request = new RestRequest();
        request.requestUri = 'https://sharatchikkanna-dev-ed.my.salesforce.com/services/apexrest/Accounts/0012800000mwrhkAAA/contacts';
        request.httpMethod = 'GET';
        RestContext.request = request;
        
        system.debug('test account result = '+ AccountManager.getAccount());


        
    }
    

}