({
	getIndustryPicklist: function(component, event) {
        var action = component.get("c.getIndustry");
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                var result = response.getReturnValue();                
                var industryMap = [];
                for(var key in result){
                    industryMap.push({label: result[key], value: key});
                }
                component.set("v.industryMap", industryMap);
            }
        });
        $A.enqueueAction(action);
	
	},
    
    recordTypesList : function(component, event, helper){
        
        var action = component.get("c.recordTypes1");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var result = response.getReturnValue();
                var recMap = [];
                for(var key in result){
                    //recMap.push({key : key , value : result[key]});
                    recMap.push({label: result[key], value: key});
                }
                component.set("v.recMap",recMap);
            }
            
        });
        $A.enqueueAction(action);
        
    }
})