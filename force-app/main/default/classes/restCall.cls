@RestResource(urlMapping='/Dialogflow')
global class restCall {
    @HTTPPost
    global static string createRecords(){
        //response from Google Assistant as a JSON
        String request = RestContext.request.requestBody.toString();
    //deserialize the JSON
        mapurl orp = (mapurl)JSON.deserialize(request, mapurl.class);
        string str=orp.result.metadata.intentName;
 
        //check whether it is an account
        if((str.contains('New')||(str.contains('Add')) ||(str.contains('Create'))) &&(str.contains('Account'))){
            account acc= new account();
            acc.name=orp.result.parameters.Name;
            acc.Phone=orp.result.parameters.phone;
            acc.Email__c=orp.result.parameters.Email;
            insert acc;
        }
    //check whether it is a contact
        else if((str.contains('New')||(str.contains('Add')) ||(str.contains('Create'))) &&(str.contains('Contact'))){
            contact con= new contact();
            con.LastName = orp.result.parameters.Name;
            con.Phone = orp.result.parameters.phone;
            con.Email = orp.result.parameters.Email;
            insert con;
        }
        String s= 'Success';
        return s;
    }
    //wrapper to get the values from the JSON
    global class mapurl{
        global result result;
    }
    global class result{
        global parameters parameters;
        global metadata metadata;
        global string resolvedQuery;
    }
    global class parameters{
        global String Phone;
        global String Name;
        global String Email;
    }
    global class metadata{
        global String intentName;
    }
}