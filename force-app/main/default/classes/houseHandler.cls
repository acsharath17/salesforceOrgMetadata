public class houseHandler {
    public static Map<Id,String> recordtypeList {get;set;}
    
    @auraEnabled
    public static Map<Id,String> recordTypes1(){
        List<Schema.RecordTypeInfo> recordTypes = House__c.sObjectType.getDescribe().getRecordTypeInfos();
        recordtypeList = new Map<Id,String>();
        
        for(RecordTypeInfo rc : recordTypes){
             if(rc.getName() != 'Master')
            recordtypeList.put(rc.getRecordTypeId(),rc.getName());
            //recordtypeList.put('One','One');
        }
        
        return recordtypeList;
    }
    
    @AuraEnabled
    public static Id getRecTypeId(String recordTypeLabel){
        Id recid = Schema.SObjectType.House__c.getRecordTypeInfosByName().get(recordTypeLabel).getRecordTypeId();        
        return recid;
    }
    
    @AuraEnabled //get Account Industry Picklist Values
    public static Map<String, String> getIndustry(){
        Map<String, String> options = new Map<String, String>();
        //get Account Industry Field Describe
        Schema.DescribeFieldResult fieldResult = Account.Industry.getDescribe();
        //get Account Industry Picklist Values
        List<Schema.PicklistEntry> pList = fieldResult.getPicklistValues();
        for (Schema.PicklistEntry p: pList) {
            //Put Picklist Value & Label in Map
            options.put(p.getValue(), p.getLabel());
        }
        return options;
    }

}