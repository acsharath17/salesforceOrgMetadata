public with sharing class ErrorMessageInVfController1 {
    public Account acc{get;set;}
    
    public string acc_name{get;set;}
    public string acc_number{get;set;}
    public string acc_phone{get;set;}
    public string acc_site{get;set;}
    public string acc_industry{get;set;}
    
    
    public ErrorMessageInVfController1(ApexPages.StandardController controller) 
    {
        acc = new Account();
    }
    public void save(){
    
    acc.name=acc_name;
    acc.AccountNumber = acc_number;
    acc.phone = acc_phone;
    acc.site = acc_site;
    acc.industry  = acc_industry;
    //insert acc;
    
    try{
        insert acc;
    }catch(Exception e){
      if(acc.name == '' || acc.name == null)
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.FATAL,'Please enter Account name'));
 
      if(acc.AccountNumber == '' || acc.AccountNumber == null)
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Please enter Account number'));
 
      if(acc.phone == '' || acc.phone == null)
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.WARNING,'Please enter Account phone'));
 
      if(acc.site == '' || acc.site == null)
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.INFO,'Please enter Account site'));
 
      if(acc.industry == '' || acc.industry == null)
       ApexPages.addmessage(new ApexPages.message(ApexPages.severity.CONFIRM,'Please enter Account industry'));
       
     }  

    }
}