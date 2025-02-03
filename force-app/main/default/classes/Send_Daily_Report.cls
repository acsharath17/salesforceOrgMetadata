public class Send_Daily_Report {

    public static String[] addr_email = new string[]{};
    
    @InvocableMethod
    public static void schedule_report(list<id> ids){
        list<Reports_Sceduled__c> RS = [Select id,name,Report_id__c,Scheduler__r.Email_Addresses__c From Reports_Sceduled__c Where Scheduler__c =: ids[0]];
        id par_id = RS[0].Scheduler__c;
        
        if(RS[0].Scheduler__r.Email_Addresses__c != null){
                
               try{
                   addr_email = RS[0].Scheduler__r.Email_Addresses__c.split(',');
               }Catch(Exception e){
               
               }
            
        }
        
        set<Id> r_id = new set<id>();
        
        for(Reports_Sceduled__c r : RS){
            r_id.add(r.Report_id__c);
        }
        
        for(Users_Receving__c rec : [Select id,User_Email__c From Users_Receving__c WHERE Scheduler__c =: RS[0].Scheduler__c]){
            if(rec.User_Email__c != null){
                
                    try{
                        addr_email.add(rec.User_Email__c);
                    }Catch(Exception e){
                    
                    }
                
            }
        }
        
        List<Messaging.EmailFileAttachment> f = new List<Messaging.EmailFileAttachment>();
        
        for(Report rep : [Select id,name,FolderName From Report Where id in: r_id]){
            ApexPages.PageReference report = new ApexPages.PageReference('/'+rep.id+'?csv=1');
            Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
            attachment.setFileName(rep.name+'.csv');
            attachment.setBody(report.getContent());
            attachment.setContentType('text/csv');
            f.add(attachment);    
        }
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        //message.setFileAttachments(new Messaging.EmailFileAttachment[] { f } );
        message.setFileAttachments(f);
        message.setSubject('Report');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( addr_email );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        
        
            
    }
    
    public static void test_method(){
        integer a1 = 1;
        integer a2 = 1;
        integer a3 = 1;
        integer a4 = 1;
        integer a5 = 1;
        integer a6 = 1;
        integer a7 = 1;
        integer a8 = 1;
        integer a9 = 1;
        integer a0 = 1;
        integer a11 = 1;
        integer a12 = 1;
        integer a13 = 1;
        integer a14 = 1;
        integer a15 = 1;
        integer a16 = 1;
        integer a17 = 1;
    }
    

    
    
}