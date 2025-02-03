({
	getContacts : function(component) {
		var action = component.get('c.getContacts');
        action.setParams({
            "accId" : component.get("v.recordId")
        });
        var self = this;
        action.setCallback(this,function(actionResult){
            component.set('v.contacts',action.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})