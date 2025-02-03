({
	getAccountList : function(component) {
		var action = component.get('c.getAccounts');
        
        var self = this;
        action.setCallback(this,function(actionResult){
            component.set('v.accounts',action.getReturnValue());
        });
        $A.enqueueAction(action);
	}
})