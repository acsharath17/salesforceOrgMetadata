public with sharing class permissionController {
    public permissionController() {

    }

    @AuraEnabled
    public static string savePermission(List<fieldAndPermission> updatedPermission){
        system.debug('updated Permission --- '+updatedPermission[1]);
        string abc = string.valueOf(updatedPermission[1]);
        return abc;
    }

    @AuraEnabled
    public static List<fieldAndPermission> permissionSets(string fieldAPI, string objectAPI){
        
        string objectAndField = objectAPI+'.'+fieldAPI;
        map<Id,FieldPermissions> permissionSetAndFieldPermMap = new map<Id,FieldPermissions>();
        for(FieldPermissions fps : [Select Id,PermissionsEdit,PermissionsRead,ParentId from FieldPermissions WHERE 
                                    Field =:objectAndField AND 
                                    SobjectType =: objectAPI]){
            permissionSetAndFieldPermMap.put(fps.ParentId,fps);
        }

        List<fieldAndPermission> fp = new List<fieldAndPermission>();
        map<Id,PermissionSet> permissionSetMap = new map<Id,PermissionSet>([Select Id,Name from PermissionSet WHERE isCustom = true]);       
        for(PermissionSet ps : permissionSetMap.values()){
            fieldAndPermission per = new fieldAndPermission();
            per.permissionSetName = ps.name;
            per.permissionSetId = ps.Id;
            per.readPermission = permissionSetAndFieldPermMap.containsKey(ps.Id) ? permissionSetAndFieldPermMap.get(ps.Id).PermissionsRead : false ;
            per.writePermission = permissionSetAndFieldPermMap.containsKey(ps.Id) ? permissionSetAndFieldPermMap.get(ps.Id).PermissionsEdit : false ;
            
            fp.add(per);
        }
        return fp;
    }

    @Auraenabled(cacheable=true)
    public static List<string> getAllObject(){
        List<string> objectList = new List<string>();

        List<Schema.SObjectType> objects = Schema.getGlobalDescribe().Values();

        for(integer i = 0 ; i <= 100 ; i++){
            string objName = objects[i].getDescribe().getName();
            if((!objName.containsignorecase('history') && !objName.containsignorecase('tag')&&
                !objName.containsignorecase('share') && !objName.containsignorecase('feed')) || 
                objName.toLowerCase().right(3) ==  '__c'){
                    objectList.add(objName);
            }
        }
        return objectList;
    }

    @Auraenabled(cacheable=true)
    public static List<FieldWrap> getAllFields(string objectName)
    {
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe(); 
        Schema.SObjectType ctype = gd.get(objectName); 
        Map<String, Schema.SobjectField> fmap = ctype.getDescribe().fields.getMap();   
        List<FieldWrap> strList = new List<FieldWrap>();
        for(String fieldName: fmap.keySet()) {
            FieldWrap wmp = new FieldWrap();
            wmp.name = fieldName;
            wmp.label = fmap.get(fieldName).getDescribe().getLabel();        
            strList.add(wmp);
        }
        return strList;
    }

    public class FieldWrap
    {
        @Auraenabled
        public string Name{get;set;}
        @Auraenabled
        public string Label{get;set;}
    }

    public class fieldAndPermission{
        @AuraEnabled
        public string permissionSetName{get;set;}
        @AuraEnabled
        public string permissionSetId{get;set;}
        @AuraEnabled 
        public boolean readPermission{get;set;}
        @AuraEnabled 
        public boolean writePermission{get;set;}
    }
}