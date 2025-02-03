trigger test_2 on Opportunity (before Insert) {
    
    Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
    Schema.SObjectType leadSchema = schemaMap.get('Opportunity');
    Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
    //Opportunity opp = [Select id,name,accountId from Opportunity];
    Map<String,String> valueMap = new Map<String,String>();

    for ( Opportunity o : Trigger.new) {
        for ( String fieldName : fieldMap.keySet() ) {
            system.debug('Opportunity------------'+o.get(fieldName));
            system.debug('Field--------------'+fieldName);
            valueMap.put(string.ValueOf(fieldName), string.valueof(o.get(fieldName)));
            
        }
    }
    system.debug('ValueMap----------'+valueMap);
    
}