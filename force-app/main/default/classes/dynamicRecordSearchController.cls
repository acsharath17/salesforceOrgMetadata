public with sharing class dynamicRecordSearchController{
    /*
     * Description : This function is used to get list of values from search setting object and these values will be displayed as a picklist
     * Date		   : 11/04/2018
     * Parameter   : sObject , string
     */
    
    @AuraEnabled
    public static List < String > getselectOptions(sObject objObject, string fld) {
        List < String > allOpts = new list < String > (); //List of object API which will be displayed in UI
        try{        	
            for(search_setting__c ss : [Select Id,Name from search_Setting__c] ){
                allOpts.add(string.valueOf(ss.Name));
            }        
            allOpts.sort();    
        }catch(exception e){
        	system.debug('Error : '+e.getMessage());    
        }        
        return allOpts;
    }
    /*
     * Description : This function is used to display record and filter the records
     * Date	       : 11/04/2018
     * Parameter   : String - ObjectAPI , string - search name for filtering
     */
    
    @AuraEnabled
    public static object Get_Record_For_Table_Input_From_Query(String objectName, string recordName)
    {
        
        String queryFields;
        String fullQuery;        
		string qry = 'Select Id,Name,Fields_To_Display__c from Search_Setting__c WHERE Name = \''+objectName +'\'';				
        List<Search_Setting__c> ss = database.query(qry);		
        queryFields = string.valueOf(ss[0].Fields_To_Display__c);
        fullQuery = 'Select '+queryFields+ ' From '+objectName;
        if(!string.isBlank(recordName))
            fullQuery += ' WHERE Name Like \'%'+recordName+'%\'';
        
        system.debug('objectName'+objectName);
        system.debug('fullQuery ** '+fullQuery);
        system.debug('queryFields'+queryFields);
        Integer headerindex=0; 
        TargetTable TargetTable_inst = new TargetTable();
        List<EachRecord> allListOfRecords = new List<EachRecord>();
        String Query=fullQuery;
        //split all the fields into a list of strings
        List<String> fieldList= queryFields.split(',');
        //Creating a Dynamic Object Type with Custom object name
        String listType = 'List<' + objectName + '>';
        //Creating a Dynamic Record Type with Custom object name
        String EachRecordType =  ''+objectName+'';
        System.debug('listType'+listType);
        System.debug('EachRecordType'+EachRecordType);
        List<SObject> ListOfRecords;
        SObject IndividualMember;
        boolean isMyObjectAccessible=true;
        //Creating a generic Sobject to hold data of custom object
        try{
            SObjectType sObjectType = Schema.getGlobalDescribe().get(objectName);
            isMyObjectAccessible = sObjectType.getDescribe().isAccessible();
            system.debug('isMyObjectAccessible'+isMyObjectAccessible);
            //Creating a generic Sobject to hold data of custom object
            ListOfRecords = (List<SObject>)Type.forName(listType).newInstance();
            IndividualMember = (SObject)Type.forName(EachRecordType).newInstance();
            //Execute the Query to get and store the data in Generic object
            ListOfRecords = Database.query(Query);
            system.debug('ListOfRecords'+ListOfRecords);  
            //removing not accessible fields from the List of Fields to display
            Set<String> notAccessibleFields = new Set<String>();
            for (SObjectField field : sObjectType.getDescribe().fields.getMap().values()){
                if (!field.getDescribe().isAccessible()){ 
                    notAccessibleFields.add(String.valueOf(field));
                } 
            }
            system.debug('accessibleFields'+notAccessibleFields);
            List<Integer> ListtoRemove = new List<Integer>();
            Integer toRemove=0;
            for(String field :fieldList)
            {
                if(notAccessibleFields.contains(field))
                {
                    ListtoRemove.add(toRemove);
                }
                
                toRemove++;            
            }
            system.debug('fieldList'+fieldList);
            system.debug('ListtoRemove'+ListtoRemove);
            if(ListtoRemove.size()>0){
                for(Integer Removefield :ListtoRemove)
                {
                    fieldList.remove(Removefield);
                }
            }
            system.debug('accessibleFields'+fieldList);
            
        }
        catch(Exception e)
        {
            return null;
        }
        if(isMyObjectAccessible){
            for(Integer i=0;i<ListOfRecords.size();i++)
            {
                IndividualMember = ListOfRecords[i];
                EachRecord Each_record_nested_List_Of_Fields = new EachRecord();
                List<object> temp = new List<object>();
                for(String field :fieldList)
                {   //record id
                    if(field=='id')
                    {
                        Each_record_nested_List_Of_Fields.recordId=(Id)IndividualMember.get(field);
                    }
                    //if there is any relation like account.name
                    if(field.containsAny('\\.'))
                    {
                        List<String> relation = field.split('\\.');
                        //get the actual value not id in relation
                        temp.add(IndividualMember.getSobject(relation[0]).get(relation[1]));
                    }
                    else
                    {		//except is store in all field and values
                        if(field!='id'){
                            temp.add((IndividualMember.get(field)==null)?'':IndividualMember.get(field));
                        }
                    }
                }
                System.debug('i='+i+'-'+temp);
                Each_record_nested_List_Of_Fields.recordValue=temp;
                allListOfRecords.add(Each_record_nested_List_Of_Fields);
            }
            
            //prepare header
            List<header> headerList = new List<header>();
            
            for(String field :fieldList)
            {
                if(field!='id'){
                    header h = new header();
                    h.index=headerindex++;
                    String s = field;
                    //removing __c
                    Integer i=s.lastIndexOf('_');
                    if(i!=-1)
                    {
                        s=s.substring(0,i);
                    }
                    //replacing _ with space so we get account_name = account name
                    s=s.replaceAll('_',' ');
                    system.debug('String'+s);
                    h.name=s;
                    h.sorted=2;
                    headerList.add(h);
                }
            }
            
            TargetTable_inst.headerList=headerList;
            TargetTable_inst.records=ListOfRecords;
            TargetTable_inst.ListOfEachRecord=allListOfRecords;
            return TargetTable_inst;
        }//if the object is not accessible it return null
        else
        {
            return null;
        }
        
    }
    public class header{
        @AuraEnabled public String name; //Name of the Field
        @AuraEnabled public String api;  //Api of the Field
        @AuraEnabled public Integer sorted; //Is the FieldSorted
        @AuraEnabled public Integer index; //Index of the Field on record
    }
    public class EachRecord{
        @AuraEnabled public List<object> recordValue;  //Record
        @AuraEnabled public Id recordId; //Record Id used for Firing Events
    }
    public class TargetTable{
        @AuraEnabled public List<header> headerList; //Header wrapper
        @AuraEnabled public List <sObject> records; //actual list of records
        @AuraEnabled public List <EachRecord> ListOfEachRecord;//all data will be saved as array of array values
        @AuraEnabled public List <EachRecord> SwapVariable;//curated wrapped list of record facilitated for table 
        
    }
    
}