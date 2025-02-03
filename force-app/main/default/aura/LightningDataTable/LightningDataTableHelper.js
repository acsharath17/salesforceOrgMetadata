({
	getDataHelper : function(component,event) {
		var action = component.get("c.getAccRecords");
        //Set the Object parameters and Field Set name
        action.setParams({
            strObjectName : 'Account',
            strFieldSetName : 'DataTableFieldSet'
        });
        action.setCallback(this, function(response){
            if(response.getState() === 'SUCCESS'){
                console.log(response.getReturnValue().lstDataTableColumns);
                component.set("v.mycolumns",response.getReturnValue().lstDataTableColumns);
                component.set("v.mydata",response.getReturnValue().lstDataTableData);
            }else if(state === 'ERROR'){
                var errors = response.getError();
                if(errors){
                    if(errors[0] && errors[0].message){
                        console.log("Error Message : "+errors[0].message);
                    }
                }else{
                   console.log("Unknown Error"); 
                }
            }else{
                console.log('Something went wrong, Please check with your admin');
            }
        });
        $A.enqueueAction(action);
	}
})