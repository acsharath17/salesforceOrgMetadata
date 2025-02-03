global class Handel_Rejected_Approval implements Messaging.InboundEmailHandler {
    global Messaging.InboundEmailResult handleInboundEmail(Messaging.InboundEmail email,Messaging.InboundEnvelope envelope) 
    {
        Messaging.InboundEmailResult result = new Messaging.InboundEmailresult();
        system.debug('AAAAAAA'+email);
        system.debug(email.plaintextbody);
        system.debug('BBBBBBBBBB'+email.subject);
        
        
        
            string email_body = email.Plaintextbody;
            system.debug('VVVVVVVVVVVVV'+email_body);
            system.debug('MMMMMMMMMMMMM'+email.Plaintextbody);
            string[] aa = email_body.split('\n');
            system.debug('@@@@@@@@@@@@'+aa);
            
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
            String[] toAddresses = new String[] {'devinandana24@gmail.com','chikkannasharath@gmail.com'};
            mail.setSenderDisplayName('Salesforce Support');
            mail.setToAddresses(toAddresses);
            mail.setSubject('Sharat Can Spam' );
            mail.setPlainTextBody('Ha ha ha ha ha ha ha ha........');
            Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        
        return null;
    }    
}