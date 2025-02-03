public with sharing class massDeleteController {

    private ApexPages.StandardSetController standardController;

    public massDeleteController(ApexPages.StandardSetController controller) {
        this.standardController = standardController;
    }
    
    public PageReference deleteLog() {
        Set<Id> selected = new Map<Id, SObject>(standardController.getSelected()).keySet();        
        delete [select Id from case where Id in :selected];    
        return standardController.cancel();
    }

}