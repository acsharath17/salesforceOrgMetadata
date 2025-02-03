({
	searchHelper : function(component, event) {
		
        //component.find("Id_spinner").set("v.class" , 'slds-show');
        debugger;
        var action = component.get("c.fetchAccount");
        action.setParams({
            "searchKeyword":component.get("v.searchKeyword"),
            "fields" : component.get("v.searchFields"),
            "objectName" : component.get("v.searchObject")
        });
        action.setCallback(this, function(response) {
            component.find("Id_spinner").set("v.class" , 'slds-hide');
            var state = response.getState();
            alert(state);
            if(state === "SUCCESS"){
                var storeResponse = response.getReturnValue();
                alert(storeResponse);
                component.set("v.totalNumberOfRecord", storeResponse.length);
                component.set("v.searchResult", storeResponse);
            }else if (state === "INCOMPLETE") {
                alert('Response is Incompleted');
            }else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        alert("Error message: " + 
                                    errors[0].message);
                    }
                } else {
                    alert("Unknown error");
                }
            }
        });
	},
})