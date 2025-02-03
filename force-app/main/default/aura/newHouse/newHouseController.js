({
 
    doInit: function(component, event, helper) {        
        helper.getIndustryPicklist(component, event);
        helper.recordTypesList(component, event);
    },

    recordTypesList : function(component, event, helper){
        component.set("v.isOpen", true);
        var action = component.get("c.recordTypes1");
        action.setCallback(this, function(response){
            //component.set("v.listOfRecordType", response.getReturnValue());
            var result = reponse.getReturnValue();
            var arrayMapKeys = [];
            for(var key in results){
                arrayMapKeys.push({label: result[key] , value: key});
            }
            component.set("v.listOfRecordType", arrayMapKeys);
            
        });
        $A.enqueueAction(action);
        
    },   
    
    createHouse: function (component) {
        //component.set("v.isOpen", true);
        var action = component.get("c.getRecordTypeId");
        var recordTypeLabel = component.find("selectid").get("v.value");
        action.setParams({
            "recordTypeLabel" : recordTypeLabel 
        });
        action.setCallback(this, function(response){
            var state = reponse.getState();
            if(state === "SUCCESS"){
                var createRecordEvent =$A.get("e.force:createRecord");
                var RecTypeId = reponse.getReturnValue();
                createRecordEvent.setParams({
                    "entityApiName" : 'House__c',
                    "recordTypeId" : RecTypeId
                });
                createRecordEvent.fire();
            }
        });
        $A.enqueueAction(action);
    },
    closeModal: function(component, event, helper) {
      // set "isOpen" attribute to false for hide/close model box 
      component.set("v.isOpen", false);
   },
 
   openModal: function(component, event, helper) {
      // set "isOpen" attribute to true to show model box
      component.set("v.isOpen", true);
   },
    
    rtChange : function(component, event, helper){
        var rt = component.get("v.selected2");
        alert(rt);
    }
})