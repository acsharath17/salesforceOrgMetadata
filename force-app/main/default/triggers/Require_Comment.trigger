trigger Require_Comment on Opportunity (before update) {
    
    map<id,Opportunity> rejectedStatements = new map<id,Opportunity>();
    
    for(Opportunity opty : trigger.new){
        
        Opportunity oldOpp = System.Trigger.Oldmap.get(opty.id);
        
        if(oldOpp.Approval_Status__c != 'Rejected' && opty.Approval_Status__c == 'Rejected' ){
            rejectedStatements.put(opty.id,opty);
        }
    }
    
    if(!rejectedStatements.isEmpty())
    {
        List<id> processInstanceIds = new List<id>{};
        
        for(Opportunity opp : [SELECT (SELECT id FROM ProcessInstances ORDER BY CreatedDate DESC LIMIT 1) FROM Opportunity WHERE ID in: rejectedStatements.keyset()])
        {
            processInstanceIds.add(opp.ProcessInstances[0].Id);
        }
        List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
        
        for(ProcessInstance pi : [SELECT TargetObjectId,(SELECT Id, StepStatus, Comments FROM Steps ORDER BY CreatedDate DESC LIMIT 1 ) FROM ProcessInstance WHERE Id IN :processInstanceIds ORDER BY CreatedDate DESC]){
            if((pi.Steps[0].Comments == null || pi.Steps[0].Comments.trim().length() == 0)){
                system.debug('DDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
                rejectedStatements.get(pi.TargetObjectId).addError('Operation Cancelled: Please provide a rejection reason!');
                List<String> sendTo = new List<String>();
                sendTo.add('chikkannasharath@gmail.com');
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(sendTo);
                mail.setSenderDisplayName('Approval Rejection Error');
                mail.setSubject('ERROR');
                mail.setplaintextbody('Error Message Body');
                mails.add(mail);
            }
        }
        Messaging.sendEmail(mails);
    }
}