({
	createRecord: function (component) {
        var createRecordEvent = $A.get('e.force:createRecord');
        if ( createRecordEvent ) {
            createRecordEvent.setParams({
                'entityApiName': 'Account',
                'defaultFieldValues': {
                    'Type' : 'Prospect',
                    'Industry' : 'Apparel',
                    'Rating' : 'Hot'
                }
            });
            createRecordEvent.fire();
        } else {
            /* Create Record Event is not supported */
            alert("Account creation not supported");
        }
    }
})