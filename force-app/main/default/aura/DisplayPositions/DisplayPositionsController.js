({
    doInit : function(component, event, helper) {
        helper.getPosition(component);
    },
    
    doSomething : function(component, event, helper) {
        
        var lstPositions = component.get("v.lstPositions");
        
        //To check if list is not empty or null
        if(!$A.util.isEmpty(lstPositions) && !$A.util.isUndefined(lstPositions)){
            
            //Calling the Apex Function
            var action = component.get("c.performAction");
                                  
            //Json Encode to send the data to Apex Class
            var positionRecords = JSON.stringify(lstPositions);
            //Setting the Apex Parameter
            action.setParams({
                positionRecords : positionRecords
            });
            
            //Setting the Callback
            action.setCallback(this,function(a){
                //get the response state
                var state = a.getState();
                
                //check if result is successfull
                if(state == "SUCCESS"){
                    
                    //Perform Action after the result
                    alert('Success in calling server side action');
                    
                } else if(state == "ERROR"){
                    alert('Error in calling server side action');
                }
            });
            
            //adds the server-side action to the queue        
            $A.enqueueAction(action);
            
        }
        
        
    }
})