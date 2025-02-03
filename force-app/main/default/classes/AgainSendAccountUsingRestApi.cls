public class AgainSendAccountUsingRestApi {
    String clientId ='3MVG9AzPSkglhtpt3l4KpvaFQR3RZJIE0E3AAt2yY59JHfNCcxBLLgaCnfl4WrtYVkJfVi.W6ZBeKK_ZVpblz'; 
    String clientsecret='A139B68368997057DA0DAD78191273184E706FEB1AAF80BF2B249C1B22EAAA88'; 
    string username='schikkanna@guidewire.com.sharathv3'; 
    String password='Welcome2020'; 
    String accesstoken_url='https://test.salesforce.com/services/oauth2/token';
    String authurl='https://test.salesforce.com/services/oauth2/authorize';
      
    public class deserializeResponse{
        public String id;
        public String access_token;   
    }
    public String ReturnAccessToken(AgainSendAccountUsingRestApi Acc){
        String reqbody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password; 
        Http h= new Http();
        HttpRequest req= new HttpRequest();
        req.setBody(reqbody);
        req.setMethod('POST');
        
        req.setEndpoint('https://guidewire--sharathv3.salesforce.com/services/oauth2/token'); //Change "ap4" in url to your Target Org Instance 
        HttpResponse res=h.send(req);
        System.debug(res.getBody()+'By-AP-1986-Response');
        deserializeResponse resp1=(deserializeResponse)JSON.deserialize(res.getBody(),deserializeResponse.class);
        System.debug(resp1+'By-AP-deserializeresponse');
        return resp1.access_token;
    }
    
    @future(callout=true)
    public static void createAccount(String Accname, String Phone, String Website){
    
        AgainSendAccountUsingRestApi acc1= new AgainSendAccountUsingRestApi();
        String accessToken=acc1.ReturnAccessToken(acc1);
        System.debug(accessToken+'###AP');
        if(accessToken!=null){
            String endPoint='https://guidewire--sharathv3.salesforce.com/services/data/v32.0/sobjects/Account'; //Change "ap4" in url to your Destination Org  
            String jsonstr='{"Name":"'+ Accname +'","Phone":"'+ Phone +'","Website":"'+ Website +'"}';
            Http h2= new Http();
            HttpRequest req2= new HttpRequest();
            req2.setHeader('Authorization','Bearer ' + accessToken);
            req2.setHeader('Content-Type','application/json');
            req2.setHeader('accept','application/json');
            req2.setBody(jsonstr);
            req2.setMethod('POST');
            req2.setEndpoint(endPoint);
            HttpResponse res2=h2.send(req2);
            System.debug(res2+'###1203createresp');
            deserializeResponse deresp2=(deserializeResponse)System.JSON.deserialize(res2.getBody(),deserializeResponse.class);
            System.debug('###1203createdeser'+deresp2);
        }
    }
}