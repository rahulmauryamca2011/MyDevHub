({
    getAccountChildList : function(component, event) {
        debugger;
        var action = component.get("c.getAccountDetails");
        action.setParams({
            "accountId": component.get('v.recordId'),
            "conTitle": component.get('v.filter')
        });
        action.setCallback(this, function(response) {
            console.log('reponse',  response.getReturnValue());
            component.set("v.accountObj", response.getReturnValue());            
        });
        $A.enqueueAction(action);
    }       
})