public with sharing class Email_Attachment {
    
    public string ParentId;
    
    public List<Attachment> att {get;set;}
    public String toUnselect {get; set;}
    public Integer rowNum{get;set;}
    
    public Email_Attachment(ApexPages.StandardController controller) {
        att = new List<Attachment>();
        ParentId = ApexPages.CurrentPage().getParameters().get('Id');
        att = [Select id,Name,Body from Attachment Where ParentId =: this.ParentId];  
    }
    
    public List<Attachment> getAllAttachments(){
        return att;
    }
    
    public void remove(){
        integer indexVal = integer.valueof(system.currentpagereference().getparameters().get('index'));
        system.debug('DDDDDDDDDDDDD '+indexVal);
        att.remove(indexVal);
        getAllAttachments();
    }
    
    Public void SendEmail(){
        string[] emailAddresses = new String[]{'chikkannasharath@gmail.com'};
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        mail.setToAddresses(emailAddresses);
        //mail.setCcAddresses(ccAddresses);
        mail.setReplyTo('chikkannasharath@gmail.com');
        mail.setSenderDisplayName('Support');
        mail.setSubject('Mail has been sent');
        mail.setBccSender(false);
        mail.setUseSignature(false);
        mail.setPlainTextBody('Your Email has been sent');
        //mail.setTargetObjectId(temp.Id);
        //mail.setWhatId(temp.Id);
        List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
        for (Attachment a : att)
        {
           Messaging.Emailfileattachment efa = new Messaging.Emailfileattachment();
          efa.setFileName(a.Name);
          efa.setBody(a.Body);
          fileAttachments.add(efa);
        }
        mail.setFileAttachments(fileAttachments);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
    }

}