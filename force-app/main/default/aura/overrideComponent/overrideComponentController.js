({
	createAccount : function(component, event, helper) {
        var createRecordEvent = $A.get('e.force:createRecord');
        if(createRecordEvent){
            createRecordEvent.setParams({
                'entityApiName':'Contact',
                'defaultValues':{
                    'FirstName': 'Sharat',
                    'LastName' : 'Chikkanna'
                }
            });
            createRecordEvent.fire();
        }else{
            alert('Contact Creation Not Supported');
        }
	}
})