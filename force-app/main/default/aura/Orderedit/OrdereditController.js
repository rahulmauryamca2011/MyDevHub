({
	doInit : function(component, event, helper) {
		var createOrder=component.get("c.createBP");
        var recId = component.get("v.recordId");
        if(recId != null)
        {
            createOrder.setParams({
                "recId" : recId
            });
            createOrder.setCallback(this,function(response){
                if(response.getState()==='SUCCESS'){
                    var So = JSON.parse(response.getReturnValue());
                    console.log(so);
                    component.set("v.SalesOrder", So);
                }
            });
           $A.enqueueAction(createOrder); 
        }
    }    
})