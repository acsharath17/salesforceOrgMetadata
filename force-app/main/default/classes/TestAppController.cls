public class TestAppController {
	@auraEnabled
    public static void savePDFOpportunity(){
        PageReference pdfPage = new PageReference('/apex/pdfPage');
		pdfPage.getParameters().put('Id', '006280000058tzbAAA');
        Blob pdfContent = pdfPage.getContent();
        
        Messaging.EmailFileAttachment attachment = new Messaging.EmailFileAttachment();
        attachment.setFileName('Sample.pdf');
        attachment.setBody(pdfContent);        
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        message.setFileAttachments(new Messaging.EmailFileAttachment[] { attachment } );
        message.setSubject('PDF Email Attachment in Lightning');
        message.setPlainTextBody('The report is attached.');
        message.setToAddresses( new String[] { 'schikkanna@deloitte.com','chikkannasharath@gmail.com' } );
        Messaging.sendEmail( new Messaging.SingleEmailMessage[] { message } );
        
    }
}