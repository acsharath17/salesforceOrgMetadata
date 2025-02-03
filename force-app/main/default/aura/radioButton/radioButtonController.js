({
    doInit: function(component, event, helper){
    	helper.getContacts(component);            
    },
    onGroup: function(component, event, helper) {
        var selected = event.getSource().get("v.text");
        
    }

})