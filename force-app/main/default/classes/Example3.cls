public class Example3 {

    public String acc_name{get;set;}
    public String acc_phone{get;set;}
    public string acc_fax{get;set;}
    public string acc_website{get;set;}
    public string acc_Industry{get;set;}
    
    public integer a{get;set;}
    public integer b{get;set;}
    public integer d;
    
    public integer c{get;set;}
    
    public void res(){
        try{
        c = a*b*d;
        }catch(Exception e){
            if(d==null)
            ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter Account phone'+e.getMessage()));
        }
         
        
    }
    
    public Example3() {

    }
    
    public pagereference onSave(){
        Account acc = new Account();
        system.debug('@@@@@@@@@@@@@@@@@@@@@@@@22'+acc_name);
        acc.name = acc_name;
        acc.Phone = acc_phone;
        acc.Fax = acc_fax;
        acc.website = acc_website;
        
        insert acc;
        
        return new pagereference('/'+acc.id);
    }


    public Example3(ApexPages.StandardController controller) {

    }

}