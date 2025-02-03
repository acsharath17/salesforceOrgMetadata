public class Assign2_Account_ext {

    public Assign2_Account_ext() {

    }


    public Assign2_Account_ext(ApexPages.StandardController controller) {

    }
    
    public String AccountName{get;set;}
    public String Rating{set;get;}
    public String AccountNumber{set;get;}
    public String Phone{set;get;}

    //Contact
        public String FirstName1{get;set;}
    public String LastName1{set;get;}
    public String Mobile1{set;get;}
    public String CPhone{set;get;}
   //public String AccountId{set;get;}    
    Account accObj=new Account();
           
    public pagereference save_account_record()
    {            
           //insert accObj;
          accObj=new Account();
          accObj.Name=AccountName;
          accObj.Rating=Rating;
          accObj.AccountNumber=AccountNumber;
          accObj.Phone=Phone;                                 
           
          /*PageReference newocp= new PageReference('/apex/Assign2_Contact');
          newocp.setRedirect(true); */ 
            
            return page.account_contact_2;
    }
    
    public pagereference Save_record()
    {
    
           insert accObj;
           
           Contact conObj=new Contact();
           conObj.FirstName=FirstName1;
           conObj.LastName=LastName1;
           conObj.MobilePhone=Mobile1;
           conObj.Phone=CPhone;   
           conObj.AccountID=accObj.id;                              
           
           insert conObj;
           
           return new pagereference('/'+conobj.id);
    }

}