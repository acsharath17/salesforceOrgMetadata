public with sharing class FiedlPermissionClass {
    
    public string nameFile{get;set;}
    public Blob contentFile{get;set;}
    public String[] filelines = new String[]{};
    
    
    public Pagereference ReadFile(){
        nameFile=contentFile.toString();
        filelines = nameFile.split('\n');
        
        ProfilePermissionHandler PP = new ProfilePermissionHandler();
        
        MetadataService.Metadata[] FLS_Permission = new MetadataService.Metadata[]{};
        MetadataService.MetadataPort service = PP.createService();
        
        for (Integer i=1;i<filelines.size();i++){
            system.debug('filelines-------'+filelines);
            String[] inputvalues = new String[]{};
            inputvalues = filelines[i].split(',');
            system.debug('----------------'+inputvalues[0]+' '+ inputvalues[1] +' '+ inputvalues[2]);
            MetadataService.Profile prof = pp.updateFieldLevelSecurity(inputvalues[0],inputvalues[1],inputvalues[2],true);
            system.debug('Prof---------------'+prof);
            FLS_Permission.add(prof);
            system.debug('FLS_Permission-----------------'+FLS_Permission);
        }
         
        system.debug('FLS_Permission*****************'+FLS_Permission);
        List<MetadataService.SaveResult> results = service.updateMetadata( FLS_Permission );
        
    return null;
    }
}