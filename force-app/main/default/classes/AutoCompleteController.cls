global class AutoCompleteController {
    /*Global variables*/
    public String searchedRecordId { get; set; }
    public static list<ResultSet> searchedRecord {get;set;}    
    @RemoteAction
    global static ResultSet[] getRecords(String searchText) {
        //sObject List
        searchedRecord = new list<ResultSet>();
        //SOSL Text should be more then one charecter
        if(searchText.length() >0){
            //SOSL opretion to retrive records of the Account, Lead, Contact, Opportunity, Lead Objects you can add more.
            List<List<SObject>> searchList = [FIND :searchText IN ALL FIELDS RETURNING Account (Id, Name,Description), Contact(Id, Name,Description), Opportunity(Id, Name,Description), Lead(Id, Name,Description)];
            //Adding diffrent object's records in sobject list
            for(List<SObject> o:searchList){
                for(SObject s:o){
                    searchedRecord.add(new autoCompleteController.ResultSet(s));
                } 
            }
        }
        return searchedRecord;
    }
    /*getGlobalDescribed*/
    private static list<Schema.SObjectType> gd{
        get{
            if(gd == null){
                gd = Schema.getGlobalDescribe().values();
            }
            return gd ;
        }set;
    }
    /*Record Wrapper*/
    global class ResultSet{
        public String Id {get;set;} 
        public String Name{get;set;}
        public String Description {get;set;}
        public String sObjectName {get;set;}
        public ResultSet(sObject s){
            this.Id = s.Id;
            this.Name = s.get('Name')+'';
            this.Description = s.get('Description')+'';
            this.sObjectName = getsObjectNameById(Id);            
        }       
        global ResultSet(String Id,String Name,String Description){
            this.Id = Id;
            this.Name = Name;
            this.Description = Description;
            this.sObjectName = getsObjectNameById(Id);            
        }
        /*To get object Name by Id*/
        private String getsObjectNameById(String sObjectId){            
            if(sObjectId != null && sObjectId.trim() != ''){
                for(Schema.SObjectType objectInstance : autoCompleteController.gd){
                    if(objectInstance.getDescribe().getKeyPrefix() == sObjectId.subString(0,3)){    
                        return objectInstance.getDescribe().getLabel();
                    }
                }
            }
            return null;
        }
    }
}