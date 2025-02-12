({
    getExpenses: function(component) {
var action = component.get("c.getExpenses");
action.setCallback(this, function(response) {
var state = response.getState();
if (component.isValid() && state === "SUCCESS") {
component.set("v.expenses", response.getReturnValue());
this.updateTotal(component);
}
});
$A.enqueueAction(action);
},
updateTotal : function(component) {
var expenses = component.get("v.expenses");
var total = 0;
for(var i=0; i<expenses.length; i++){
var e = expenses[i];
//If you’re using a namespace, use e.myNamespace__Amount__c instead
total += e.Amount__c;
}
//Update counters
component.set("v.total", total);
component.set("v.exp", expenses.length);
},//Delimiter for future code
})