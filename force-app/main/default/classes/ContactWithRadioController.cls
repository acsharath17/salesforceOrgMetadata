/**
*@purpose : Apex Controller resposible for displaying all contact in a pageblock table form where we can delete edit contact 
*@author :  Ashis.behera 
**/
public class ContactWithRadioController {

     //variable to hold Contact Record and id
     public Contact contact{get;set;}
     public Id contactId{get;set;}
     
     //wrapperlist variable to hold contact
     List<ContactWrapper> contactList = new List<ContactWrapper>();
     
     /**
    *@purpose : Standard Parameterised Constructor to create Contact Reference
    **/
     public ContactWithRadioController(ApexPages.StandardController controller) {
         Contact contact = new Contact();
           
     }
     
      /**
       *@purpose : Method to display contacts in a table 
       *@Param : None 
       *@Return : List<contactwrapper>
      **/
        public  List<ContactWrapper> getContacts() {
            for(Contact c: [SELECT Id,Name,Accountid,Account.Name,MobilePhone,Email FROM Contact ORDER BY createdDate DESC]){
                contactList.add(new ContactWrapper(c));
             }   
                return contactList;
        }
        
        /**
         *@purpose : Method to hold selected contacts  
         *@Param : None 
         *@Return : Pagereference
         **/
          public PageReference getSelected() {
              System.debug('======Inside the Get Function======');
              contactId = ApexPages.currentPage().getParameters().get('id');
               System.debug('======Inside the Get Function======' +contactId);
               contact = [SELECT Id,Name,Accountid,Account.Name,MobilePhone,Email FROM Contact WHERE id = :contactId]; 
              return null;
          }
          
         /**
         *@purpose : Method to hold selected contacts  
         *@Param : None 
         *@Return : Pagereference
         **/
          public PageReference savingContact() {
              UPSERT contact;
              return null;
          }
         /**
          *@purpose : wrapper class to use check box inside the table   
          *@author :  Ashis.behera 
         **/
         public class ContactWrapper {
             public Contact con{get; set;}
             public Boolean selected{get; set;}
             public ContactWrapper(Contact c) {
                con = c;
                selected = false;
             }
         }
           
  }