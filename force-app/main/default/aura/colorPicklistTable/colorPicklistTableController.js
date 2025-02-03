({
	loadContactList : function(component, event, helper) {
		
        var action = component.get('c.fetchContact');
        
        action.setCallback(this, function(response) {
            var state = reponse.getState();
            if(state == "SUCCESS") {
                component.set('v.ListOfContact',response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
	}

})