({
	onLoad : function(component, event, helper) {
		console.log('colorCmp load');
        var sName = component.get("v.leadSource");
        if(sName != undefined) {
            // **** write picklist values in Lower Case ***** //       
      		var tempLowerCase = sName.toLowerCase();
      		var cOrange = 'web';
      		var cYellow = 'public relations';
      		var cPink = 'trade show';
      		var cLightGreen = 'purchased list';
            
            // set the color on based on picklist values      
          	if (cOrange.indexOf(tempLowerCase) != -1) {
            	component.set("v.Color", 'orange');
          	} else if (cYellow.indexOf(tempLowerCase) != -1) {
            	component.set("v.Color", 'Yellow');
          	} else if (cPink.indexOf(tempLowerCase) != -1) {
            	component.set("v.Color", 'pink');
          	} else if (cLightGreen.indexOf(tempLowerCase) != -1) {
            	component.set("v.Color", 'LightGreen');
          	}
        }
	},
})