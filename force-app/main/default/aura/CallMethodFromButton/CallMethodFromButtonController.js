({
	myAction : function(component, event, helper) {
		var action = cmp.get("c.callBatch");		
		action.setCallback(this, function(response) {
   		
        if (response.state === "SUCCESS"){
        	var serverResponse = response.getReturnValue();
   		}
            
		});
		$A.enqueueAction(action);	
	}
})