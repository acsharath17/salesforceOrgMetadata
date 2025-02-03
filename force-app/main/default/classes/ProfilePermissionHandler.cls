public class ProfilePermissionHandler{
    
    public MetadataService.Metadata[] xyz = new MetadataService.Metadata[]{};
    public MetadataService.MetadataPort service = createService();
    
    public MetadataService.Profile updateFieldLevelSecurity(string ProfileFullName, String ObjectAPI , String FieldAPI, boolean isCustomObj)
    {
        MetadataService.MetadataPort service = createService();
        MetadataService.Profile admin = new MetadataService.Profile();
        admin.fullName = ProfileFullName;
        admin.custom = isCustomObj;
        MetadataService.ProfileFieldLevelSecurity fieldSec = new MetadataService.ProfileFieldLevelSecurity();
        fieldSec.field= ObjectAPI+'.'+FieldAPI;
        fieldSec.editable=true;
        admin.fieldPermissions  = new MetadataService.ProfileFieldLevelSecurity[] {fieldSec} ;
        //xyz.add(admin);
        //List<MetadataService.SaveResult> results = service.updateMetadata(new MetadataService.Metadata[] { admin });
        //List<MetadataService.SaveResult> results1 = service.updateMetadata( xyz );
        //handleSaveResults(results1[0]);
        return admin;
    }
    
    //List<MetadataService.SaveResult> results = service.updateMetadata(new MetadataService.Metadata[] { xyz } );
    
    public class MetadataServiceExamplesException extends Exception { }
    
    public MetadataService.MetadataPort createService()
    {
        MetadataService.MetadataPort service = new MetadataService.MetadataPort();
        service.SessionHeader = new MetadataService.SessionHeader_element();
        service.SessionHeader.sessionId = UserInfo.getSessionId();
        return service;
    }
    
    public void handleSaveResults(MetadataService.SaveResult saveResult)
    {
        // Nothing to see?
        if(saveResult==null || saveResult.success)
            return;
        // Construct error message and throw an exception
        if(saveResult.errors!=null)
        {
            List<String> messages = new List<String>();
            messages.add(
                (saveResult.errors.size()==1 ? 'Error ' : 'Errors ') +
                    'occured processing component ' + saveResult.fullName + '.');
            for(MetadataService.Error error : saveResult.errors)
                messages.add(
                    error.message + ' (' + error.statusCode + ').' +
                    ( error.fields!=null && error.fields.size()>0 ?
                        ' Fields ' + String.join(error.fields, ',') + '.' : '' ) );
            if(messages.size()>0)
                throw new MetadataServiceExamplesException(String.join(messages, ' '));
        }
        if(!saveResult.success)
            throw new MetadataServiceExamplesException('Request failed with no specified error.');
    }    
}