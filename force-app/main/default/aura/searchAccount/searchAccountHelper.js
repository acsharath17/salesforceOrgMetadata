({
	SearchHelper : function(component, event) {
		var action = component.get("c.fetchAccount");
        action.setParams({
            'searchKeyWord' : component.get("v.searchKeyword")
        });
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var storeResponse = response.getReturnValue();
                if(storeResponse.length == 0){
                    component.set("v.Message", true);
                }else{
                    component.set("v.Message", false);
                }
                component.set("v.numberOfRecord", storeResponse.length);
                component.set("v.searchResult", storeResponse);
            }
        });
        $A.enqueueAction(action);
	},
})