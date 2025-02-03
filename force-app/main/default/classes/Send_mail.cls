Public Class Send_mail{
    
    @InvocableMethod
    public static void schedule_report(list<id> ids){
        list<Hotel__c> RS = [Select id,name,Email__c,Email_Body__c From Hotel__c Where id =: ids[0]];
        
        string q = RS[0].Email_Body__c;
        string[] addr_email = new String[]{RS[0].Email__c};
        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        //message.setFileAttachments(new Messaging.EmailFileAttachment[] { f } );
        //message.setFileAttachments(f);
        message.setSubject('Report');
        message.sethtmlBody (RS[0].Email_Body__c);
        message.setToAddresses( addr_email );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
    }
}