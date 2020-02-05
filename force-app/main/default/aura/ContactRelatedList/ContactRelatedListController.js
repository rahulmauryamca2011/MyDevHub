({
    createRecord : function (component, event, helper) {
        var createRecordEvent = $A.get("e.force:createRecord");
        createRecordEvent.setParams({
            "entityApiName": "Case",
            "defaultFieldValues": {
                'ContactId' : component.get('v.contactObj.Id')
            }
        });
        createRecordEvent.fire();
    },
    applycss:function(component,event){
        //alert(event.target.id);
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('MB-Back');
        $A.util.addClass(cmpTarget, 'slds-fade-in-open');
        $A.util.addClass(cmpBack, 'slds-backdrop--open');
    },
    removecss:function(component,event){
        var cmpTarget = component.find('Modalbox');
        var cmpBack = component.find('MB-Back');
        $A.util.removeClass(cmpBack,'slds-backdrop--open');
        $A.util.removeClass(cmpTarget, 'slds-fade-in-open');        
    },  
    editRecord : function(component, event, helper) {
        var editRecordEvent = $A.get("e.force:editRecord");
        editRecordEvent.setParams({
            "recordId": component.get("v.contactObj.Id")
        });
        editRecordEvent.fire();
    },
    deleter : function(component, event, helper) {
        helper.deleter1(component, event);
    },
    doInit : function(component,event,helper)
    {
    	
    	var action = component.get("c.FindChildMatter");  
        action.setParams({
            "recordId":component.get('v.contactObj.Id')
        });
		action.setCallback(this, function(response) {
            component.set("v.count", response.getReturnValue()); 
        });        
        $A.enqueueAction(action);
        
	}
    
})