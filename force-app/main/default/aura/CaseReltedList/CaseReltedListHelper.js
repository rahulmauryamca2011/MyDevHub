({
    initilizeVariables : function(component, event) {   
        //alert("hit=="+component.get('v.contactId'));
        var action = component.get("c.getCaseList");        
        action.setParams({
            contactId : component.get('v.recordId')
        });
        
        action.setCallback(this, function(a) {
            if (a.getState() === "SUCCESS") {
                component.set('v.contactObj', a.getReturnValue());
               // alert("hit--"+component.get('v.contactObj').Cases.size());
                console.log('contact', component.get('v.contactObj').Cases);
            } else if (a.getState() === "ERROR") {
                $A.log("Errors", a.getError());
            }
        });        
        $A.enqueueAction(action);
    }
})