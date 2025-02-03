({
    doInit : function(component, event, helper) {
		helper.fetchPickListVal(component, 'Industry' , 'accIndustry');	
	},
    onPicklistChange : function (component, event, helper){
    	//alert(event.getSource().get("v.value")); 
        var sel = event.getSource().get("v.value");
        component.set("v.selValue",sel);
    },
    getRecordsForTable : function(component, event, helper) {
        var action=component.get("c.Get_Record_For_Table_Input_From_Query");
        
        var obj = component.get("v.selValue");
        var rec = component.get("v.recName");
        action.setParams({"objectName":obj, "recordName":rec});
        
        action.setCallback(this,function(response)
                           {
                               component.set("v.Table_header_Records",response.getReturnValue());
                               var records = component.get("v.Table_header_Records");
                               console.log(component.get("v.Table_header_Records"));
                               if(records==null)
                               {
                                   component.set("v.Error", true);
                                   component.set("v.showHeaders",false);
                               }
                               if (records!=null && records.ListOfEachRecord.length == 0) {
                                   component.set("v.Message", true);
                                   component.set("v.showHeaders",false);
                                   
                               } else {
                                   component.set("v.Message", false);
                                   component.set("v.showHeaders",true);
                               }
                           });
        $A.enqueueAction(action);
    },
    
    sortColumn : function(component, event, helper) {
        var ctarget = event.currentTarget;
        var Fieldindex = ctarget.dataset.value;
        console.log("selected Field"+Fieldindex);
        var Wrapedrecords = component.get("v.Table_header_Records");
        var objectRecord = Wrapedrecords.ListOfEachRecord;
        var headerRecord = Wrapedrecords.headerList;
        console.log(headerRecord);
        for(var i=0;i<headerRecord.length;i++){
            console.log("loop:"+headerRecord[i].name+" - "+Fieldindex);
            if(headerRecord[i].index==Fieldindex)
            {	console.log("match entered");
             var sorted = headerRecord[i].sorted;
             if(sorted==1)
             {
                 //desc
                 console.log("descending");
                 objectRecord.sort(function(a,b) {
                     return (a['recordValue'][headerRecord[i].index].toString().toLowerCase()  < b['recordValue'][headerRecord[i].index].toString().toLowerCase() ) ? 1 : ((b['recordValue'][headerRecord[i].index].toString().toLowerCase()  < a['recordValue'][headerRecord[i].index].toString().toLowerCase() ) ? -1 : 0);} );
                 sorted=0;
             }
             else if(sorted==0 || sorted==2)
             {
                 console.log("ascending");
                 objectRecord.sort(function(a,b) {return (a['recordValue'][headerRecord[i].index].toString().toLowerCase()  > b['recordValue'][headerRecord[i].index].toString().toLowerCase() ) ? 1 : ((b['recordValue'][headerRecord[i].index].toString().toLowerCase()  > a['recordValue'][headerRecord[i].index].toString().toLowerCase() ) ? -1 : 0);} ); 
                 sorted=1;
             }
             headerRecord[i].sorted=sorted; 
             
            }
            else{
                headerRecord[i].sorted=2;
            }
        }
        Wrapedrecords.records=objectRecord;
        Wrapedrecords.headerList=headerRecord;
        console.log(Wrapedrecords);
        component.set("v.Table_header_Records",Wrapedrecords);
        
        
    },
    DOSomeThingOnCLickOfARow : function(component, event, helper) {
        var ctarget = event.currentTarget;
        //we can get the record id of the row in table.
        var id_str = ctarget.dataset.value;        
        debugger;
        var navEvt = $A.get("e.force:navigateToSObject");
    	navEvt.setParams({
      		"recordId": id_str,
            "slideDevName": "detail"
        });
    	navEvt.fire();
        
    }
    
})