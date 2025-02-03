({
    init: function(component, event, helper) {
        component.set("v.items", [
        { expanded: false, title: "Row 1" },
        { expanded: false, title: "Row 2" },
        { expanded: false, title: "Row 3" }
        ]);
    },
    toggle: function(component, event, helper) {
        var items = component.get("v.items"), index = event.getSource().get("v.value");
        items[index].expanded = !items[index].expanded;
        component.set("v.items", items);
    }
})