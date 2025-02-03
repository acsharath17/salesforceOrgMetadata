public with sharing class contactDataController {
    
    
    public List<Object> contacts {get;set;}    
    public List<Contact> cons{get;set;}
    public boolean createCon{get;set;}
    public HttpResponse response1;
    public HttpResponse response;
    
    public contactDataController (){                       
        createCon = true;
        contacts = new List<Object>();
        cons = new List<Contact>();
        
    }
    
    /*
    *@ Description : function to handle response and send data to front end
    */
    public void contactFetch(){
                
        HttpResponse response = newCall();
               
        
        if (response.getStatusCode() == 200) {
            List<Object> results = (List<Object>) JSON.deserializeUntyped(response.getBody());           
            contacts.addAll(results);
            
            // Hadling data from response if request is success
            for(Object ab : results){
                Map<String,Object> data = (Map<String,Object>)ab;
                                               
                Contact cc = new Contact();
                cc.FirstName = string.valueOf(data.get('fname'));
                cc.LastName = string.valueOf(data.get('lname'));
                cc.Username__c = string.valueOf(data.get('uname'));
                cons.add(cc);
                
                // this boolean is set to false to enable button in UI to create contact 
                if(!cons.isEmpty())
                    createCon = false;
            }
        }
    }
    
    /*
    *@ Description : function to make callout to external system
    */
    public static HttpResponse newCall(){
        
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint('http://www.filltext.com/?rows=500&fname={firstName}&lname={lastName}&uname={username}&delay=20');
            request.setMethod('GET');
            request.setTimeout(21000); // this is becuase dealy is 20 sec in the request
            HttpResponse response = http.send(request);                   
            return Response;                    
    }
    
    /*
    *@ Description : function to create contact data
    */
    public void createContact(){
        if(!cons.isEmpty())
            upsert cons;
    }
       
}