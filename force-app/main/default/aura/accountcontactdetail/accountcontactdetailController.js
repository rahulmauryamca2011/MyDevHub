({
	doInit : function(component, event, helper) {
		var action = component.get("c.getaccount");
       // action.setParams({
       //     "accountId":component.get('v.recordId')
       // });
        action.setCallback(this, function(response) {
          //  console.log('reponse',  response.getReturnValue());
          //  
            component.set("v.accountobj", response.getReturnValue()); 
            alert('Comonent'+ component.get("v.accountobj"));
            var acList= component.get("v.accountobj");
            alert(acList[0]);
            console.log(acList[0]);
          //  debugger;
        });
        $A.enqueueAction(action);
	}
})