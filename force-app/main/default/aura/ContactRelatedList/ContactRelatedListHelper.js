({
    deleter1 : function(component, event) {    
        var action = component.get("c.deleteRecord");        
        action.setParams({
            recordId : component.get('v.contactObj.Id')
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
                location.reload();
            } else if (a.getState() === "ERROR") {
                $A.log("Errors", a.getError());
            }
        });        
        $A.enqueueAction(action);
    }
})