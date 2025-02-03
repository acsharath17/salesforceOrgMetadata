global with sharing class Submit_Approval_ButtonClass {
    webservice static string Apr_Submit(String parentid){
        Quote_Line__c LI = [Select id,name from Quote_Line__c WHERE Quote_Line_Item__c =: parentid];
        
        Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
        req.setComments('Send Record for Approval');
        req.setObjectId(LI.Id);
        req.setSubmitterId(UserInfo.getUserId());
        
        Approval.ProcessResult Result = Approval.process(req);
        return null;
    }
}