({
	Search : function(component, event, helper) {
		var searchKeyFId = component.find("searchId");
        var srcValue = searchKeyFId.get("v.value");
        if(srcValue == '' || srcValue == null){
            searchKeyFId.set("v.errors",[{
                message:"Enter Search Keyword"
            }]);
        }else{
            searchKeyFId.set("v.errors",null);
            helper.SearchHelper(component,event);
        }
	},
})