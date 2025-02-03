global class Btach_add_User_to_Group implements Database.Batchable<sObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        String query = 'SELECT Id,Name,Region__c FROM User WHERE UserRoleId != Null and ContactId != null and IsPortalEnabled = true ';
        return Database.getQueryLocator(query);
    }
   
    global void execute(Database.BatchableContext BC, List<User> scope) {
         
         Map<string,string> grp = new map<string,string>();
         grp.put('NOAM','00G28000002ttcv');
         grp.put('APAC','00G28000002ttd0');
         grp.put('EU','00G28000002ttd5');
         
         List<GroupMember> Group_List = new List<GroupMember>();
         
         for(User a : scope)
         {
             GroupMember GM = new GroupMember();
             GM.UserOrGroupId = a.Id;
             
             GM.GroupId = grp.get(a.Region__c);
             Group_List.add(GM);            
         }
         insert Group_List;
    }   
    
    global void finish(Database.BatchableContext BC) {
    }
}