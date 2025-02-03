public class AssignmentRule_Controller {
    
    public string SelectedObject{get;set;}
    public string SelectedField{get;set;}
    public List<Wrapper> wap{get;set;}
    public string hh;
    public Integer rowCount;
    
    public AssignmentRule_Controller(){
        wap = new List<Wrapper>();
        rowCount = 0;
        wap.add(new Wrapper(SelectedObject,SelectedField,rowCount));
    }
    
    public List<SelectOption> getObjects(){
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('','--None--'));
        for(SALES_TERRITORY_ROUTING__c objt : [Select Name,ObjectAPI__c from SALES_TERRITORY_ROUTING__c]){
            options.add(new SelectOption(objt.ObjectAPI__c,objt.Name));
        }
        return Options;
    }
    
    public void callfun(){
        system.debug('aww---------'+wap[rowCount].objectN);
        wrapper wa = new Wrapper(wap[rowCount].objectN,null,null);    
    }
    
    public List<SelectOption> getFields(){
        
        system.debug('------------------ '+SelectedObject);
        system.debug('Wrapper----------- '+wap[rowCount].objectN);
        system.debug('Wap--------------- '+wap);
        
        String type=wap[rowCount].objectN;
        
        List<SelectOption> Options = new List<SelectOption>();
        Options.add(new SelectOption('','--None--')); 
               
        If(string.isNotBlank(type)){
            Map<String, Schema.SObjectType> ObjectMap = Schema.getGlobalDescribe();
            Schema.SObjectType ObjectSchema = ObjectMap.get(type);
            Map<String, Schema.SObjectField> FieldMap = ObjectSchema.getDescribe().fields.getMap();
            
            for (String fieldName: FieldMap.keySet()) {
                System.debug('API Name---------------| '+fieldName);                 
                string lab = fieldMap.get(fieldName).getDescribe().getLabel();
                options.add(new SelectOption(fieldName,lab));
            }
        }
        return Options;
        
    }
    
    public Void Tabb(){
        rowCount+=1;
        wap.add(new Wrapper(SelectedObject,SelectedField,rowCount));
        
    }
    
    public class wrapper{
        public string fieldN{get;set;}
        public string objectN{get;set;}
        public integer row{get;set;}
        public List<SelectOption> Fields{get;set;}
        public List<SelectOption> Objects{get;set;}
        
        public Wrapper(string ab,string cd, integer rCount){
            objectN = ab;
            fieldN = cd;
            row = rCount;
            
            system.debug('1111 '+ab+' 222222 '+cd);
            
            Objects = new List<SelectOption>();
            Objects.add(new SelectOption('','--None--'));
            for(SALES_TERRITORY_ROUTING__c objt : [Select Name,ObjectAPI__c from SALES_TERRITORY_ROUTING__c]){
                Objects.add(new SelectOption(objt.ObjectAPI__c,objt.Name));
            }
            
            system.debug('Fields----------- '+Fields);
            
            Fields = new List<SelectOption>();
            Fields.add(new SelectOption('','--None--'));                    
            If(string.isNotBlank(ab)){
            system.debug('abbbbbb----'+ab);
                Map<String, Schema.SObjectType> ObjectMap = Schema.getGlobalDescribe();
                Schema.SObjectType ObjectSchema = ObjectMap.get(ab);
                Map<String, Schema.SObjectField> FieldMap = ObjectSchema.getDescribe().fields.getMap();
                system.debug('******** '+FieldMap);
                for (String fieldName: FieldMap.keySet()) {
                    System.debug('API Name---------------| '+fieldName);                 
                    string lab = fieldMap.get(fieldName).getDescribe().getLabel();
                    Fields.add(new SelectOption(fieldName,lab));
                }
            }
            
            system.debug('FFFF----------- '+Fields);
            
        }
    }
}